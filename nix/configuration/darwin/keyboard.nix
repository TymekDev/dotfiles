{ lib, ... }:
let
  inherit (lib) fromHexString;
in
{
  system.keyboard = {
    enableKeyMapping = true;
    nonUS.remapTilde = true;
    remapCapsLockToEscape = true;
    builtinKeyboardOnly = true;
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

      # Tilde -> Caps lock (non US keyboard)
      {
        HIDKeyboardModifierMappingSrc = fromHexString "0x700000035";
        HIDKeyboardModifierMappingDst = fromHexString "0x700000039";
      }
    ];
  };
}
