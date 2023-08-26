local world_path = minetest.get_worldpath()
local org_file = world_path .. "/beds_spawns"
local file = world_path .. "/beds_spawns"
local bkwd = false

-- check for PA's beds mod spawns
local cf = io.open(world_path .. "/beds_player_spawns", "r")
if cf ~= nil then
	io.close(cf)
	file = world_path .. "/beds_player_spawns"
	bkwd = true
end

function Beds.read_spawns()
	local spawns = Beds.spawn
	local input = io.open(file, "r")
	if input and not bkwd then
		repeat
			local x = input:read("*n")
			if x == nil then
				break
			end
			local y = input:read("*n")
			local z = input:read("*n")
			local name = input:read("*l")
			spawns[name:sub(2)] = { x = x, y = y, z = z }
		until input:read(0) == nil
		io.close(input)
	elseif input and bkwd then
		Beds.spawn = minetest.deserialize(input:read("*all"))
		input:close()
		Beds.save_spawns()
		os.rename(file, file .. ".backup")
		file = org_file
	end
end

Beds.read_spawns()

function Beds.save_spawns()
	if not Beds.spawn then
		return
	end
	local data = {}
	local output = io.open(org_file, "w")
	for k, v in pairs(Beds.spawn) do
		table.insert(data, string.format("%.1f %.1f %.1f %s\n", v.x, v.y, v.z, k))
	end
	output:write(table.concat(data))
	io.close(output)
end

function Beds.set_spawns()
	for name, _ in pairs(Beds.player) do
		local player = minetest.get_player_by_name(name)
		local p = player:get_pos()
		-- but don't change spawn location if borrowing a bed
		if not minetest.is_protected(p, name) then
			Beds.spawn[name] = p
		end
	end
	Beds.save_spawns()
end

function Beds.remove_spawns_at(pos)
	for name, p in pairs(Beds.spawn) do
		if vector.equals(vector.round(p), pos) then
			Beds.spawn[name] = nil
		end
	end
	Beds.save_spawns()
end
