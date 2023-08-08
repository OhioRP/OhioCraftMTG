minetest.register_node("portcraft:cool", {
    on_rightclick = function(_, _, clicker, _, _)
        if clicker:is_player() then
            minetest.chat_send_player(clicker:get_player_name(), S("Did you know you've just clicked a very cool block?"))
        end
    end,
    description = S("Cool XD"),
    tiles = {
        "portcraft_block_cool_upndown.png",
        "portcraft_block_cool_upndown.png",
        "portcraft_block_cool_sides.png",
        "portcraft_block_cool_sides.png",
        "portcraft_block_cool_sides.png",
        "portcraft_block_cool_sides.png",
    },
    sounds = {
        dug = { name = "portcraft_block_cool_dug", gain = 0.6 },
        dig = { name = "portcraft_block_cool_dig", gain = 0.1 }
    },
    groups = { oddly_breakable_by_hand = 3 }
})

minetest.register_craft({
    type = "shaped",
    output = "portcraft:cool 1",
    recipe = {
        { "default:stick", "default:stick", "default:stick" },
        { "default:stick", "wool:white",    "default:stick" },
        { "default:stick", "default:stick", "default:stick" }
    }
})
