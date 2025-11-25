{
  writeShellApplication,
  tarsnap-1pass,
}:
writeShellApplication {
  name = "tarsnap-1pass-backup";
  runtimeInputs = [
    tarsnap-1pass
  ];
  text = ''
    cd ~/Documents/dokumenty
    ARCHIVE_NAME="dokumenty-$(uname -n)_$(date +%Y-%m-%d_%H-%M)"
    tarsnap-1pass -f "$ARCHIVE_NAME" --cachedir ~/.cache/tarsnap -c . && echo "Created $ARCHIVE_NAME"
  '';
}
