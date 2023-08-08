local function my_register_stair_and_slab(subname, recipeitem, groups, images,
                                          desc_stair, desc_slab, sounds, worldaligntex)
    stairs.register_stair(subname, recipeitem, groups, images, S(desc_stair),
        sounds, worldaligntex)
    stairs.register_stair_inner(subname, recipeitem, groups, images, "",
        sounds, worldaligntex, S("Inner " .. desc_stair))
    stairs.register_stair_outer(subname, recipeitem, groups, images, "",
        sounds, worldaligntex, S("Outer " .. desc_stair))
    stairs.register_slab(subname, recipeitem, groups, images, S(desc_slab),
        sounds, worldaligntex)
end

local function create_new_stone_like_node(name, durability, generate)
    local name_no_underscore, _ = string.gsub(name, '_', '')
    local inventory_name = JoinWithSpace(Split(name, "_"))
    local sounds = {
        footstep = { name = "portcraft_blocktype_stone", gain = 0.25 },
        dug = { name = "portcraft_blocktype_stone", gain = 1 },
        dig = { name = "portcraft_blocktype_stone", gain = 0.7 },
        place = { name = "portcraft_blocktype_stone", gain = 1 }
    }

    minetest.register_node("portcraft:" .. name, {
        description = S(inventory_name),
        tiles = {
            "portcraft_block_" .. name_no_underscore .. "_upndown.png",
            "portcraft_block_" .. name_no_underscore .. "_upndown.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
        },
        sounds = sounds,
        groups = { cracky = durability }
    })

    my_register_stair_and_slab(
        name_no_underscore,
        "portcraft:" .. name,
        { cracky = durability },
        { "portcraft_block_" .. name_no_underscore .. "_sides.png" },
        inventory_name .. " Stair",
        inventory_name .. " Slab",
        sounds,
        false
    )

    walls.register(
        "portcraft:" .. name .. "_wall",
        S(inventory_name .. " Wall"),
        { "portcraft_block_" .. name_no_underscore .. "_sides.png" },
        "portcraft:" .. name,
        sounds
    )

    if generate then
        -- stolen from minetest game's gravel generation
        minetest.register_ore({
            ore_type        = "blob",
            ore             = "portcraft:" .. name,
            wherein         = { "default:stone" },
            clust_scarcity  = 16 * 16 * 16,
            clust_size      = 5,
            y_max           = 31000,
            y_min           = -31000,
            noise_threshold = 0.0,
            noise_params    = {
                offset = 0.5,
                scale = 0.2,
                spread = { x = 5, y = 5, z = 5 },
                seed = 766,
                octaves = 1,
                persist = 0.0
            },
        })
    end
end

create_new_stone_like_node("ancient_debris", 1, false)
minetest.register_craft({
    type = "shaped",
    output = "portcraft:ancient_debris 1",
    recipe = {
        { "group:stone", "group:stone", "group:stone" },
        { "group:stone", "group:stone", "group:stone" },
        { "group:stone", "group:stone", "group:stone" }
    }
})

create_new_stone_like_node("diorite", 2, true)
minetest.register_craft({
    type = "shaped",
    output = "portcraft:diorite 1",
    recipe = {
        { "default:cobble",       "default:mese_crystal" },
        { "default:mese_crystal", "default:cobble" }
    }
})

create_new_stone_like_node("andesite", 2, true)
minetest.register_craft({
    type = "shapeless",
    output = "portcraft:andesite 1",
    recipe = { "default:cobble", "portcraft:diorite" }
})
