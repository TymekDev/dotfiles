local expr_flake = [[
(let
  findFlake = path:
    if builtins.pathExists (path + "/flake.nix") then path
    else findFlake (builtins.dirOf path);
in
  builtins.getFlake (toString (findFlake ./.)))
]]
local expr_pkgs = string.format("(import %s.inputs.nixpkgs { })", expr_flake)

local expr_hostname = string.format('(%s.lib.trim (builtins.readFile "/etc/hostname"))', expr_pkgs)
local expr_nixos_options = string.format("%s.nixosConfigurations.${%s}.options", expr_flake, expr_hostname)

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = expr_pkgs,
      },
      options = {
        nixos = {
          expr = expr_nixos_options,
        },
        home_manager = {
          expr = string.format("%s.home-manager.users.type.getSubOptions []", expr_nixos_options),
        },
      },
    },
  },
}
