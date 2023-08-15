local function create_door_from_wood(mod, name)
    name = Trim(string.lower(name))
    doors.register("portcraft:" .. name .. "_door", {
        tiles = { { name = "portcraft_block_door" .. name .. ".png", backface_culling = true } },
        inventory_image = "portcraft_item_door" .. name .. ".png",
        groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
        description = S(Capitalize(name) .. " Door")
    })

    minetest.register_craft({
        type = "shaped",
        output = "portcraft:" .. name .. "_door 1",
        recipe = {
            { mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood" },
            { mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood" },
            { mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood" }
        }
    })

    doors.register_trapdoor("portcraft:" .. name .. "_trapdoor", {
        inventory_image = "portcraft_block_trapdoor" .. name .. ".png",
        wield_image = "portcraft_block_trapdoor" .. name .. ".png",
        tile_front = "portcraft_block_trapdoor" .. name .. ".png",
        tile_side = "portcraft_block_trapdoor" .. name .. "_side.png",
        groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1 },
        description = S(Capitalize(name) .. " Trapdoor"),
    })

    minetest.register_craft({
        type = "shaped",
        output = "portcraft:" .. name .. "_trapdoor 1",
        recipe = {
            { mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood" },
            { mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood", mod .. ":" .. name .. "_wood" }
        }
    })
end

create_door_from_wood("default", "acacia")
create_door_from_wood("portcraft", "bamboo")
