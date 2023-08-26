-- Adapted from the code of the chest block from minetest_game:
-- https://github.com/minetest/minetest_game/blob/08e057bf1c1d99e6219551f75ad4b6366682c38c/mods/default/chests.lua#L89

local prefixed_name = "portcraft:barrel"
local def = {
    description = S("Barrel"),
    tiles = {
        "portcraft_block_barrel_sides.png",
        "portcraft_block_barrel_sides.png",
        "portcraft_block_barrel_sides.png^[transformR90",
        "portcraft_block_barrel_sides.png^[transformR90",
        "portcraft_block_barrel_frontnback.png",
        "portcraft_block_barrel_frontnback.png"
    },
    sounds = Default.node_sound_wood_defaults(),
    sound_open = "portcraft_block_barrel_open",
    sound_close = "portcraft_block_barrel_close",
    groups = { choppy = 2, oddly_breakable_by_hand = 2 }
}

local name = prefixed_name:sub(1, 1) == ':' and prefixed_name:sub(2, -1) or prefixed_name
def.paramtype = "light"
def.paramtype2 = "facedir"
def.legacy_facedir_simple = true
def.is_ground_content = false

def.on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("infotext", S("Barrel"))
    local inv = meta:get_inventory()
    inv:set_size("main", 8 * 4)
end
def.can_dig = function(pos, player)
    local meta = minetest.get_meta(pos);
    local inv = meta:get_inventory()
    return inv:is_empty("main")
end
def.on_rightclick = function(pos, node, clicker)
    local cn = clicker:get_player_name()

    if Default.chest.open_chests[cn] then
        Default.chest.chest_lid_close(cn)
    end

    minetest.sound_play(def.sound_open, {
        gain = 0.3,
        pos = pos,
        max_hear_distance = 10
    }, true)
    minetest.after(0.2, minetest.show_formspec,
        cn,
        "portcraft:barrel", Default.chest.get_chest_formspec(pos))
    Default.chest.open_chests[cn] = {
        pos = pos,
        sound = def.sound_close,
        swap = name
    }
end
def.on_blast = function(pos)
    local drops = {}
    Default.get_inventory_drops(pos, "main", drops)
    drops[#drops + 1] = name
    minetest.remove_node(pos)
    return drops
end

Default.set_inventory_action_loggers(def, "barrel")

minetest.register_node(prefixed_name, def)

-- close opened chests on load
minetest.register_lbm({
    label = "Close opened barrels on load",
    name = "portcraft:close_" .. prefixed_name:gsub(":", "_") .. "_open",
    nodenames = { prefixed_name },
    run_at_every_load = true,
    action = function(pos, node)
        node.name = prefixed_name
        minetest.swap_node(pos, node)
    end
})

minetest.register_craft({
    output = "portcraft:barrel 1",
    type = "shaped",
    recipe = {
        { "group:wood", "group:slab", "group:wood" },
        { "group:wood", "",           "group:wood" },
        { "group:wood", "group:slab", "group:wood" }
    }
})
