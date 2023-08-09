minetest.register_node("portcraft:azalea", {
    description = S("Azalea"),
    drawtype = "mesh",
    mesh = "portcraft_block_azalea.obj",
    tiles = { "portcraft_block_azalea.png" },
    groups = { snappy = 3 }
})

minetest.register_craft({
    output = "portcraft:azalea 1",
    type = "shapeless",
    recipe = { "group:leaves" }
})