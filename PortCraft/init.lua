-- Global functions

function Trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function Capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function JoinWithSpace(table)
    local return_str = ""
    for _, v in pairs(table) do
        return_str = return_str .. Capitalize(v) .. " "
    end
    return Trim(return_str)
end

function Split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

S = minetest.get_translator("portcraft")

-- Includes

local function pathjoin(...)
    local separator = package.config:sub(1, 1)
    return table.concat({ ... }, separator)
end

dofile(pathjoin(minetest.get_modpath("portcraft"), "blocks", "cool.lua"))
dofile(pathjoin(minetest.get_modpath("portcraft"), "blocks", "stone_like.lua"))
dofile(pathjoin(minetest.get_modpath("portcraft"), "blocks", "doors.lua"))
dofile(pathjoin(minetest.get_modpath("portcraft"), "blocks", "azalea.lua"))
dofile(pathjoin(minetest.get_modpath("portcraft"), "blocks", "amethyst.lua"))