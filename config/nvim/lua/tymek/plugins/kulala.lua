---@module "lazy"
---@type LazySpec
return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  keys = {
    {
      ft = "http",
      "<Leader>rs",
      function()
        require("kulala").run()
      end,
      desc = "Send request (via kulala.nvim)",
    },
  },
  opts = {
    ui = {
      default_view = "headers_body",
    },
  },
}
