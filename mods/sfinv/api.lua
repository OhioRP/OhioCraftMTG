Sfinv = {
	pages = {},
	pages_unordered = {},
	contexts = {},
	enabled = true
}

function Sfinv.register_page(name, def)
	assert(name, "Invalid sfinv page. Requires a name")
	assert(def, "Invalid sfinv page. Requires a def[inition] table")
	assert(def.get, "Invalid sfinv page. Def requires a get function.")
	assert(not Sfinv.pages[name], "Attempt to register already registered sfinv page " .. dump(name))

	Sfinv.pages[name] = def
	def.name = name
	table.insert(Sfinv.pages_unordered, def)
end

function Sfinv.override_page(name, def)
	assert(name, "Invalid sfinv page override. Requires a name")
	assert(def, "Invalid sfinv page override. Requires a def[inition] table")
	local page = Sfinv.pages[name]
	assert(page, "Attempt to override sfinv page " .. dump(name) .. " which does not exist.")
	for key, value in pairs(def) do
		page[key] = value
	end
end

function Sfinv.get_nav_fs(player, context, nav, current_idx)
	-- Only show tabs if there is more than one page
	if #nav > 1 then
		return "tabheader[0,0;sfinv_nav_tabs;" .. table.concat(nav, ",") ..
			";" .. current_idx .. ";true;false]"
	else
		return ""
	end
end

local theme_inv = [[
		image[0,5.2;1,1;gui_hb_bg.png]
		image[1,5.2;1,1;gui_hb_bg.png]
		image[2,5.2;1,1;gui_hb_bg.png]
		image[3,5.2;1,1;gui_hb_bg.png]
		image[4,5.2;1,1;gui_hb_bg.png]
		image[5,5.2;1,1;gui_hb_bg.png]
		image[6,5.2;1,1;gui_hb_bg.png]
		image[7,5.2;1,1;gui_hb_bg.png]
		list[current_player;main;0,5.2;8,1;]
		list[current_player;main;0,6.35;8,3;8]
	]]

function Sfinv.make_formspec(player, context, content, show_inv, size)
	local tmp = {
		size or "size[8,9.1]",
		Sfinv.get_nav_fs(player, context, context.nav_titles, context.nav_idx),
		show_inv and theme_inv or "",
		content
	}
	return table.concat(tmp, "")
end

---@diagnostic disable-next-line: duplicate-set-field
function Sfinv.get_homepage_name(player)
	return "sfinv:crafting"
end

function Sfinv.get_formspec(player, context)
	-- Generate navigation tabs
	local nav = {}
	local nav_ids = {}
	local current_idx = 1
	for i, pdef in pairs(Sfinv.pages_unordered) do
		if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
			nav[#nav + 1] = pdef.title
			nav_ids[#nav_ids + 1] = pdef.name
			if pdef.name == context.page then
				current_idx = #nav_ids
			end
		end
	end
	context.nav = nav_ids
	context.nav_titles = nav
	context.nav_idx = current_idx

	-- Generate formspec
	local page = Sfinv.pages[context.page] or Sfinv.pages["404"]
	if page then
		return page:get(player, context)
	else
		local old_page = context.page
		local home_page = Sfinv.get_homepage_name(player)

		if old_page == home_page then
			minetest.log("error", "[sfinv] Couldn't find " .. dump(old_page) ..
				", which is also the old page")

			return ""
		end

		context.page = home_page
		assert(Sfinv.pages[context.page], "[sfinv] Invalid homepage")
		minetest.log("warning", "[sfinv] Couldn't find " .. dump(old_page) ..
			" so switching to homepage")

		return Sfinv.get_formspec(player, context)
	end
end

function Sfinv.get_or_create_context(player)
	local name = player:get_player_name()
	local context = Sfinv.contexts[name]
	if not context then
		context = {
			page = Sfinv.get_homepage_name(player)
		}
		Sfinv.contexts[name] = context
	end
	return context
end

function Sfinv.set_context(player, context)
	Sfinv.contexts[player:get_player_name()] = context
end

function Sfinv.set_player_inventory_formspec(player, context)
	local fs = Sfinv.get_formspec(player,
		context or Sfinv.get_or_create_context(player))
	player:set_inventory_formspec(fs)
end

function Sfinv.set_page(player, pagename)
	local context = Sfinv.get_or_create_context(player)
	local oldpage = Sfinv.pages[context.page]
	if oldpage and oldpage.on_leave then
		oldpage:on_leave(player, context)
	end
	context.page = pagename
	local page = Sfinv.pages[pagename]
	if page.on_enter then
		page:on_enter(player, context)
	end
	Sfinv.set_player_inventory_formspec(player, context)
end

function Sfinv.get_page(player)
	local context = Sfinv.contexts[player:get_player_name()]
	return context and context.page or Sfinv.get_homepage_name(player)
end

minetest.register_on_joinplayer(function(player)
	if Sfinv.enabled then
		Sfinv.set_player_inventory_formspec(player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	Sfinv.contexts[player:get_player_name()] = nil
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" or not Sfinv.enabled then
		return false
	end

	-- Get Context
	local name = player:get_player_name()
	local context = Sfinv.contexts[name]
	if not context then
		Sfinv.set_player_inventory_formspec(player)
		return false
	end

	-- Was a tab selected?
	if fields.sfinv_nav_tabs and context.nav then
		local tid = tonumber(fields.sfinv_nav_tabs)
		if tid and tid > 0 then
			local id = context.nav[tid]
			local page = Sfinv.pages[id]
			if id and page then
				Sfinv.set_page(player, id)
			end
		end
	else
		-- Pass event to page
		local page = Sfinv.pages[context.page]
		if page and page.on_player_receive_fields then
			return page:on_player_receive_fields(player, context, fields)
		end
	end
end)
