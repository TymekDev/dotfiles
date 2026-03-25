{ config, pkgs, ... }:
{
  home = {
    inherit (config.dotfiles) username;
    homeDirectory = config.dotfiles.home;
    packages = [ pkgs.nix-codespace-rebuild ];
  };

  nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    use-xdg-base-directories = true;
  };

  home.file.".local/bin/xdg-open".source = pkgs.writeShellScript "request-remote-open" ''
    curl --data-urlencode "url=$1" http://localhost:8765/open
  '';

  home.sessionVariables = {
    TZ = "Europe/Warsaw";
  };
}
