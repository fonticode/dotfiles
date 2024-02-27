local plugins = {

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "bash",
        "cpp",
        "python",
        "yaml",
        "json",
        "yaml",
        "xml",
        "c",
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
       git = { enable = true },
       renderer = {
        highlight_git = true,
        icons = { show = { git = true },},
     },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",
        -- my stuff
        "jedi-language-server",
        -- c/cpp stuff
        "clangd",
        "clang-format",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
      end,
  },
}

return plugins
