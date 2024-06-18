return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({})
    end,
  },

  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("fine-cmdline").setup({})
    end,
  },
  vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true }),
}
