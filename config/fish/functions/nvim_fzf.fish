set --global --unexport fzf_pickers files live_grep

# For use in mappings. Takes a picker name.
function nvim_fzf
  # Don't do anything in $HOME as likely wanted to use a different mapping.
  if test (pwd) = "$HOME"
    return
  end
  set --function picker $argv[1]
  if not contains $picker $fzf_pickers
    echo -e "unsupported picker: '$picker'"
    return 1
  end
  nvim -c "FzfLua $picker"
end
