{ ... }:
let
  name = "maczek";
  tz = "Europe/Warsaw";
in
{
  networking.computerName = name;
  networking.hostName = name;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.variables.TZ = tz;
  time.timeZone = tz;

  system.stateVersion = 6;
}
