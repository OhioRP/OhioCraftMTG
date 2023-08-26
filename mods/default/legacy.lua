-- mods/default/legacy.lua

-- Horrible stuff to support old code registering falling nodes
-- Don't use this and never do what this does, it's completely wrong!
-- (More specifically, the client and the C++ code doesn't get the group)
function Default.register_falling_node(nodename, texture)
	minetest.log("error", debug.traceback())
	minetest.log('error', "WARNING: default.register_falling_node is deprecated")
	if minetest.registered_nodes[nodename] then
		minetest.registered_nodes[nodename].groups.falling_node = 1
	end
end

function Default.spawn_falling_node(p, nodename)
	spawn_falling_node(p, nodename)
end

-- Liquids
WATER_ALPHA              = minetest.registered_nodes["default:water_source"].alpha
WATER_VISC               = minetest.registered_nodes["default:water_source"].liquid_viscosity
LAVA_VISC                = minetest.registered_nodes["default:lava_source"].liquid_viscosity
LIGHT_MAX                = Default.LIGHT_MAX

-- Formspecs
Default.gui_suvival_form = Default.gui_survival_form
Default.gui_bg           = ""
Default.gui_bg_img       = ""
Default.gui_slots        = ""

-- Players
if minetest.get_modpath("player_api") then
	Default.registered_player_models = PlayerAPI.registered_models
	Default.player_register_model    = PlayerAPI.register_model
	Default.player_attached          = PlayerAPI.player_attached
	Default.player_get_animation     = PlayerAPI.get_animation
	Default.player_set_model         = PlayerAPI.set_model
	Default.player_set_textures      = PlayerAPI.set_textures
	Default.player_set_animation     = PlayerAPI.set_animation
end

-- Chests
Default.register_chest = Default.chest.register_chest

-- Check for a volume intersecting protection
function Default.intersects_protection(minp, maxp, player_name, interval)
	minetest.log("warning", "default.intersects_protection() is " ..
		"deprecated, use minetest.is_area_protected() instead.")
	return minetest.is_area_protected(minp, maxp, player_name, interval)
end
