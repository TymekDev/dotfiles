{ pkgs, lib, ... }:
{
  programs.bat = {
    enable = true;

    config.theme = "base16-256";
  };
}
