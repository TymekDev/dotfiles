{
  lib,
  isDarwin,
  isLinux,
  ...
}:
{
  imports = [
    ./fish.nix
    ./fonts.nix
  ]
  ++ lib.optionals isLinux [
    ./1password.nix
    ./greeter.nix
    ./i18n.nix
    ./sway.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  time.timeZone = "Europe/Warsaw";
  environment.variables.TZ = "Europe/Warsaw";

  users.users.tymek = lib.mkMerge [
    (lib.mkIf isDarwin {
      home = "/Users/tymek";
    })

    (lib.mkIf isLinux {
      isNormalUser = true;
      home = "/home/tymek";
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
      ];
    })
  ];
}
