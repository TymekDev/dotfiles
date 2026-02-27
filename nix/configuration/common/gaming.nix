{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) hasOSRS;
in
{
  environment.systemPackages =
    [ ]
    ++ lib.optionals hasOSRS [
      pkgs.bolt-launcher
    ];
}
