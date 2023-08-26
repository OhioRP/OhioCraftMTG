-- gave_initial_stuff/init.lua

local stuff_string = (minetest.settings:get("initial_stuff") or
	"default:pick_steel,default:axe_steel,default:shovel_steel,") ..
	"default:torch 99,default:cobble 99"

GiveInitialStuff = {
	items = {}
}

function GiveInitialStuff.give(player)
	minetest.log("action",
		"Giving initial stuff to player " .. player:get_player_name())
	local inv = player:get_inventory()
	for _, stack in ipairs(GiveInitialStuff.items) do
		inv:add_item("main", stack)
	end
end

function GiveInitialStuff.add(stack)
	GiveInitialStuff.items[#GiveInitialStuff.items + 1] = ItemStack(stack)
end

function GiveInitialStuff.clear()
	GiveInitialStuff.items = {}
end

function GiveInitialStuff.add_from_csv(str)
	local items = str:split(",")
	for _, itemname in ipairs(items) do
		GiveInitialStuff.add(itemname)
	end
end

function GiveInitialStuff.set_list(list)
	GiveInitialStuff.items = list
end

function GiveInitialStuff.get_list()
	return GiveInitialStuff.items
end

GiveInitialStuff.add_from_csv(stuff_string)
if minetest.settings:get_bool("give_initial_stuff") then
	minetest.register_on_newplayer(GiveInitialStuff.give)
end
