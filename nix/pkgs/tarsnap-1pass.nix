{
  writeShellApplication,
  tarsnap,
}:
writeShellApplication {
  name = "tarsnap-1pass";
  runtimeInputs = [
    tarsnap
  ];
  text = ''
    KEYFILE=$(mktemp)
    cleanup() {
      rm "$KEYFILE" 2> /dev/null
      exit
    }
    trap cleanup EXIT INT TERM

    op read "op://Private/Tarsnap.key/tarsnap.key" --force --out-file "$KEYFILE" > /dev/null
    tarsnap --keyfile "$KEYFILE" "$@"
  '';
}
