local function update_options(overrides, preserve)
  local initial = {}
  for ns, opts in pairs(overrides) do
    for opt, value in pairs(opts) do
      if preserve then
        if initial[ns] == nil then
          initial[ns] = {}
        end
        initial[ns][opt] = vim[ns][opt]
      end
      vim[ns][opt] = value
    end
  end
  return initial
end

local function with(overrides, fn)
  local initial = update_options(overrides, true)
  fn()
  update_options(initial, false)
end

return with
