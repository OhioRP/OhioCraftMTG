-- carts/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("carts")

Carts = {}
Carts.modpath = minetest.get_modpath("carts")
Carts.railparams = {}
Carts.get_translator = S

-- Maximal speed of the cart in m/s (min = -1)
Carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
Carts.punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
Carts.path_distance_max = 3


dofile(Carts.modpath .. "/functions.lua")
dofile(Carts.modpath .. "/rails.lua")
dofile(Carts.modpath .. "/cart_entity.lua")

-- Register rails as dungeon loot
if minetest.global_exists("dungeon_loot") then
	DungeonLoot.register({
		name = "carts:rail", chance = 0.35, count = { 1, 6 }
	})
end
