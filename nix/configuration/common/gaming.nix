{
  config,
  pkgs-unstable,
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
      pkgs-unstable.bolt-launcher
    ];
}
