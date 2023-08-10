minetest.register_node("portcraft:amethyst", {
    description = S("Amethyst"),
    tiles = { "portcraft_block_amethyst.png" },
    sounds = {
        footstep = { name = "portcraft_block_amethyst_step", gain = 1 },
        place = { name = "portcraft_block_amethyst_place", gain = 1 },
        dig = { name = "portcraft_block_amethyst_break", gain = 1 },
        dug = { name = "portcraft_block_amethyst_break", gain = 1 }
    },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = "portcraft:amethyst 2",
    type = "shaped",
    recipe = {
        { "default:mese_crystal", "default:mese_crystal", "default:mese_crystal" },
        { "default:mese_crystal", "default:mese_crystal", "default:mese_crystal" },
        { "default:mese_crystal", "default:mese_crystal", "default:mese_crystal" }
    }
})
