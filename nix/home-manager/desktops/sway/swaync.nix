{ config, lib, ... }:
let
  inherit (config.dotfiles) isSway;
in
{
  config = lib.mkIf isSway {
    services.swaync.enable = true;
  };
}
