{ config, lib, ... }:
let
  inherit (config.dotfiles) isSway;
in
{
  config = lib.mkIf isSway {
    services.swayosd.enable = true;
  };
}
