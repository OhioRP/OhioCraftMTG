DungeonLoot = {}

DungeonLoot.CHESTS_MIN = 0 -- not necessarily in a single dungeon
DungeonLoot.CHESTS_MAX = 2
DungeonLoot.STACKS_PER_CHEST_MAX = 8

dofile(minetest.get_modpath("dungeon_loot") .. "/loot.lua")
dofile(minetest.get_modpath("dungeon_loot") .. "/mapgen.lua")
