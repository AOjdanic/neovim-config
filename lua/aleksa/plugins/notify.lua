return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "#232136",
    })
    vim.notify = require("notify")
  end,
}
