minetest.register_node("portcraft:azalea", {
    description = S("Azalea"),
    drawtype = "mesh",
    mesh = "portcraft_block_azalea.obj",
    tiles = { "portcraft_block_azalea.png" },
    sounds = Default.node_sound_leaves_defaults(),
    groups = { snappy = 3 }
})

minetest.register_craft({
    output = "portcraft:azalea 1",
    type = "shapeless",
    recipe = { "group:leaves" }
})

minetest.register_node("portcraft:azalea_leaves", {
    description = S("Azalea Leaves"),
    drawtype = "allfaces_optional",
    tiles = { "portcraft_block_azalealeaves.png" },
    sounds = Default.node_sound_leaves_defaults(),
    groups = { snappy = 3, leaves = 1 }
})

minetest.register_craft({
    output = "portcraft:azalea_leaves 1",
    type = "shapeless",
    recipe = { "portcraft:azalea" }
})
