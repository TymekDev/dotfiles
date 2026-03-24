{
  writeShellApplication,
  gh,
}:
writeShellApplication {
  name = "setup-codespace-ssh";
  runtimeInputs = [
    gh
  ];
  text = ''
    CODESPACES=$(gh cs ls --json 'name,repository')
    REPO=$(echo "$CODESPACES" | jq -r '.[].repository' | fzf --layout reverse --height 40% --cycle || echo "No repository selected" >&2)

    if [ -z "$REPO" ]; then
      exit 1
    fi

    CS_NAME=$(echo "$CODESPACES" | jq -r ".[] | select(.repository == \"$REPO\") | .name")
    REPO_NAME=$(echo "$REPO" | cut -d '/' -f2)

    CONFIG=$(gh cs ssh --codespace "$CS_NAME" --config | sed "s,^Host .*$,Host $REPO_NAME,")
    echo "$CONFIG"
    [ -t 1 ] || exit 0 # exit if not running in a terminal

    CONFIG_FILE="$HOME/.ssh/codespaces"
    echo -n -e "\nAdd this config to $CONFIG_FILE? [y/N] "
    read -n 1 -r
    echo

    if [ "$REPLY" = "y" ] || [ "$REPLY" = "Y" ]; then
      echo "$CONFIG" >>"$CONFIG_FILE"
      echo "Config added to $CONFIG_FILE"
    else
      echo "Config not added"
    fi
  '';
}
