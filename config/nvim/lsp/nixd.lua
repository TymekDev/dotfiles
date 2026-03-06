local expr_flake = [[
(let
  findFlake = path:
    if builtins.pathExists (path + "/flake.nix") then path
    else findFlake (builtins.dirOf path);
in
  builtins.getFlake (toString (findFlake ./.)))
]]
local expr_pkgs = string.format("(import %s.inputs.nixpkgs { })", expr_flake)

local is_darwin = vim.fn.has("mac") == 1
local system = "nixos"
if is_darwin then
  system = "darwin"
end

local hostname = vim.fn.hostname():match("^([^%.]+)")
local expr_system_options = string.format("%s.%sConfigurations.%s.options", expr_flake, system, hostname)
local expr_home_manager_options = string.format("%s.home-manager.users.type.getSubOptions []", expr_system_options)

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = expr_pkgs,
      },
      options = {
        [system] = { expr = expr_system_options },
        ["home-manager"] = { expr = expr_home_manager_options },
      },
    },
  },
}
