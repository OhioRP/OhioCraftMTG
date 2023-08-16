local function create_new_wood_node(name)
    local name_no_underscore, _ = string.gsub(name, '_', '')
    local inventory_name = JoinWithSpace(Split(name, "_"))

    minetest.register_node("portcraft:" .. name .. "_wood", {
        description = S(inventory_name .. " Planks"),
        tiles = {
            "portcraft_block_" .. name_no_underscore .. "_upndown.png",
            "portcraft_block_" .. name_no_underscore .. "_upndown.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
            "portcraft_block_" .. name_no_underscore .. "_sides.png",
        },
        sounds = default.node_sound_wood_defaults(),
        groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1 }
    })

    MyRegisterStairAndSlab(
        name_no_underscore,
        "portcraft:" .. name .. "_wood",
        { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
        { "portcraft_block_" .. name_no_underscore .. "_sides.png" },
        inventory_name .. " Stair",
        inventory_name .. " Slab",
        default.node_sound_wood_defaults(),
        false
    )

    default.register_fence("portcraft:fence_" .. name, {
        description = S(inventory_name .. " Fence"),
        texture = "portcraft_block_" .. name_no_underscore .. "_sides.png",
        material = "portcraft:" .. name .. "_wood",
        groups = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3 },
        sounds = default.node_sound_wood_defaults()
    })

    doors.register_fencegate("portcraft:gate_" .. name, {
        description = S(inventory_name .. " Fence Gate"),
        texture = "portcraft_block_" .. name_no_underscore .. "_sides.png",
        material = "portcraft:" .. name .. "_wood",
        groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 }
    })
end

minetest.register_craftitem("portcraft:bamboo_stick", {
    description = S("Bamboo Stick"),
    inventory_image = "portcraft_item_bamboo.png"
})
minetest.register_craft({
    output = "portcraft:bamboo_stick 3",
    type = "shaped",
    recipe = {
        {"", "", "default:stick"},
        {"", "default:stick", ""},
        {"default:stick", "", ""}
    }
})

create_new_wood_node("bamboo")
minetest.register_craft({
    output = "portcraft:bamboo_wood 1",
    type = "shaped",
    recipe = {
        { "portcraft:bamboo_stick", "portcraft:bamboo_stick", "portcraft:bamboo_stick" },
        { "portcraft:bamboo_stick", "portcraft:bamboo_stick", "portcraft:bamboo_stick" },
        { "portcraft:bamboo_stick", "portcraft:bamboo_stick", "portcraft:bamboo_stick" }
    }
})