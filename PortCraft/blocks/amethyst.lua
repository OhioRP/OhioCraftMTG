local sounds = {
    footstep = { name = "portcraft_block_amethyst_step", gain = 1 },
    place = { name = "portcraft_block_amethyst_place", gain = 1 },
    dig = { name = "portcraft_block_amethyst_break", gain = 1 },
    dug = { name = "portcraft_block_amethyst_break", gain = 1 }
}

minetest.register_node("portcraft:amethyst", {
    description = S("Amethyst"),
    tiles = { "portcraft_block_amethyst.png" },
    sounds = sounds,
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = "portcraft:amethyst 2",
    type = "shaped",
    recipe = {
        { "default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment" },
        { "default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment" },
        { "default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment" }
    }
})

minetest.register_node("portcraft:amethyst_cluster", {
    description = S("Amethyst Cluster"),
    drawtype = "mesh",
    mesh = "portcraft_blocktype_cross.obj",
    tiles = { "portcraft_block_amethystcluster.png" },
    sounds = sounds,
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = "portcraft:amethyst_cluster 1",
    type = "shaped",
    recipe = {
        { "",                              "default:mese_crystal_fragment", "" },
        { "default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment" }
    }
})
