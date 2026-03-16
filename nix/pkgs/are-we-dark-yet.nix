{
  lib,
  stdenv,
  writeShellApplication,
  dbus,
}:
writeShellApplication {
  name = "are-we-dark-yet";
  runtimeInputs = lib.optionals stdenv.isLinux [ dbus ];
  text = ''
    OS="$(uname -s)"
    if [ "$OS" = "Darwin" ]; then
      defaults read -g AppleInterfaceStyle &>/dev/null && echo "dark" || echo "light"
    elif [ "$OS" = "Linux" ]; then
      if [ -n "''${CODESPACES:-}" ]; then
        echo "light" # I use Codespaces at work during the day
        exit 0
      fi
      dbus-send --session --print-reply=literal --reply-timeout=1000 --dest=org.freedesktop.portal.Desktop /org/freedesktop/portal/desktop org.freedesktop.portal.Settings.Read string:"org.freedesktop.appearance" string:"color-scheme" | grep -q "uint32 1" && echo "dark" || echo "light"
    else
      echo "are-we-dark-yet: unsupported OS: $OS"
      exit 1
    fi
  '';
}
