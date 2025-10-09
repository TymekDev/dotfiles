---@type vim.lsp.Config
return {
  root_markers = { "unocss.config.js", "unocss.config.ts", "uno.config.js", "uno.config.ts", "slides.md" }, -- slides.md for slidev
  workspace_required = true, -- See https://github.com/xna00/unocss-language-server/pull/23
}
