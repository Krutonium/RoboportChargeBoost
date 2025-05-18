local charge_count = settings.startup["roboport-charge-points"].value

-- Calculate grid size: nearest square that fits charge_count
local function generate_grid_positions(count)
  local positions = {}
  local grid_size = math.ceil(math.sqrt(count))
  local start = -math.floor(grid_size / 2)
  local added = 0

  for y = start, start + grid_size - 1 do
    for x = start, start + grid_size - 1 do
      table.insert(positions, {x, y})
      added = added + 1
      if added >= count then
        return positions
      end
    end
  end

  return positions
end

local new_offsets = generate_grid_positions(charge_count)

-- Apply to all roboports with charging_offsets
for name, roboport in pairs(data.raw["roboport"]) do
  if roboport.charging_offsets then
    roboport.charging_offsets = new_offsets
  end
end
