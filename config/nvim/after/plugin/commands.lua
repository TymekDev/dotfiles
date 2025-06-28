local pathlib = require("pathlib")

local wider_active_buf = vim.api.nvim_get_option_value("winwidth", {})
  > vim.api.nvim_get_option_info2("winwidth", {}).default
vim.api.nvim_create_user_command("WiderActiveBufToggle", function()
  if wider_active_buf then
    vim.opt.winwidth = vim.api.nvim_get_option_info2("winwidth", {}).default
    vim.cmd("normal =")
  else
    vim.opt.winwidth = 87
  end
  wider_active_buf = not wider_active_buf
end, {})

vim.api.nvim_create_user_command("MarkdownTableSeparator", "s/[^|]/-/g", {})

vim.api.nvim_create_user_command(
  "YaziTmux",
  ---@param tbl { args: string }
  function(tbl)
    local open_path = tbl.args
    if open_path == "" then
      open_path = vim.fn.expand("%:p:h")
    end

    -- Set up a file watcher and a timeout
    local watcher, err_name, err_msg = vim.uv.new_fs_event()
    if watcher == nil then
      vim.notify(
        string.format("Failed to create a file watcher for the Yazi chooser file: %s - %s", err_name, err_msg),
        vim.log.levels.ERROR
      )
      return
    end
    local timeout = vim.uv.new_timer()
    local cleanup = function() -- NOTE: cleanup cannot be wrapped using vim.schedule_wrap
      watcher:stop() -- NOTE: file watchers are automatically closed
      timeout:stop()
      timeout:close()
    end

    -- Prepare a callback for when Yazi writes the selection
    local tmp_path = vim.fn.tempname()
    pathlib.new(tmp_path):touch(pathlib.permission("rw-r--r--"), false) -- NOTE: watcher will fail to start if the file isn't created
    local open_callback = vim.schedule_wrap(function()
      local files = vim.fn.readfile(tmp_path)
      if #files > 1 then
        vim.notify(
          "Got more than one file from Yazi - opening the first one and ignoring the rest.",
          vim.log.levels.WARN
        )
      end

      vim.api.nvim_cmd({ cmd = "edit", args = { files[1] } }, {})
    end)

    local ok, err_name, err_msg = watcher:start(tmp_path, {}, function() ---@diagnostic disable-line: redefined-local
      open_callback()
      cleanup()
    end)
    if ok ~= 0 then
      vim.notify(
        string.format("Failed to start the file watcher for the Yazi chooser file: %s - %s", err_name, err_msg),
        vim.log.levels.ERROR
      )
      cleanup()
      return
    end

    -- Start Yazi in a new tmux window and grab the window's id
    local result = vim
      .system({
        "tmux",
        "new-window",
        "-P",
        "-F",
        "#{window_id}",
        "-t",
        "100",
        "-a",
        "yazi",
        open_path,
        "--chooser-file",
        tmp_path,
      })
      :wait()
    local window_id = vim.trim(result.stdout)

    -- Set timeout up, so we don't litter
    local MINUTE_MS = 60 * 1000
    timeout:start(
      15 * MINUTE_MS,
      0,
      vim.schedule_wrap(function()
        vim.notify("Timed out while waiting for the Yazi chooser file to be updated", vim.log.levels.WARN)
        vim.system({ "tmux", "kill-window", "-t", window_id })
        cleanup()
      end)
    )
  end,
  {
    nargs = "?",
  }
)
