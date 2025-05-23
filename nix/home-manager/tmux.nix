{ ... } :
let
  localBinScripts = paths : builtins.listToAttrs (map (name : {
    name = ".local/bin/${name}";
    value.source = ../../local/bin/${name};
  }) paths);
in
{
  home.file = localBinScripts [
    "tmux-sessionizer"
    "tmux-prefix-highlight"
    "update-theme-tmux"
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    prefix = "C-space";
    terminal = "$TERM";

   extraConfig = ''
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "fish_clipboard_copy"

      bind-key C-s run-shell tmux-sessionizer
      bind-key c new-window -c "#{pane_current_path}"
      bind-key C new-window

      set-option -g focus-events on
      run-shell "update-theme-tmux"
      set-hook -g client-focus-in 'run-shell "update-theme-tmux"'
    '';
  };
}
