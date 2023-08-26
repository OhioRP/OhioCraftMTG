minetest.register_node("portcraft:beacon", {
    description = S("Beacon"),
    drawtype = "mesh",
    mesh = "portcraft_block_beacon.obj",
    tiles = { "portcraft_block_beacon.png" },
    sounds = Default.node_sound_glass_defaults(),
    groups = { cracky = 1 }
})
minetest.register_craft({
    output = "portcraft:beacon",
    type = "shaped",
    recipe = {
        { "default:glass",    "default:glass",        "default:glass" },
        { "default:glass",    "default:mese_crystal", "default:glass" },
        { "default:obsidian", "default:obsidian",     "default:obsidian" }
    }
})
