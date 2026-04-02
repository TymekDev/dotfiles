vim.pack.add({ "https://github.com/R-nvim/R.nvim" }, { confirm = false })

-- NOTE: DON'T USE external_term = "wezterm" (or "wezterm_split"). It's buggy and has a leak of sorts.
require("r").setup({
  setwd = "nvim",
  hl_term = false,
  pdfviewer = "",
  -- FIXME: arf doesn't receive expected code blocks
  -- R_app = "arf",
})
