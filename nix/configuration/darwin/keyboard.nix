{ lib, ... }:
let
  inherit (lib) fromHexString;

  matchBuiltinKeyboard = {
    Product = "Apple Internal Keyboard / Trackpad";
    PrimaryUsagePage = 1;
    PrimaryUsage = 6;
  };

  userKeyMapping = [
    # Right Command -> Right Option
    {
      HIDKeyboardModifierMappingSrc = fromHexString "0x7000000E7";
      HIDKeyboardModifierMappingDst = fromHexString "0x7000000E6";
    }

    # Right Option -> Right Command
    {
      HIDKeyboardModifierMappingSrc = fromHexString "0x7000000E6";
      HIDKeyboardModifierMappingDst = fromHexString "0x7000000E7";
    }

    # Caps Lock -> Escape
    {
      HIDKeyboardModifierMappingSrc = 30064771129;
      HIDKeyboardModifierMappingDst = 30064771113;
    }

    # § -> Tilde (non-US)
    {
      HIDKeyboardModifierMappingSrc = 30064771172;
      HIDKeyboardModifierMappingDst = 30064771125;
    }

    # Tilde -> Caps Lock (non-US)
    {
      HIDKeyboardModifierMappingSrc = fromHexString "0x700000035";
      HIDKeyboardModifierMappingDst = fromHexString "0x700000039";
    }
  ];

in
{
  # FIXME: make this work after system restart
  system.activationScripts.keyboard.text = ''
    echo "configuring keyboard with a custom script..." >&2

    /usr/bin/hidutil property \
      --matching '${builtins.toJSON matchBuiltinKeyboard}' \
      --set '{"UserKeyMapping":${builtins.toJSON userKeyMapping}}'
  '';
}
