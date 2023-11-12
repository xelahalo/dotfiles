local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end
  },
  {
    "Pocco81/auto-save.nvim",
    event = "BufRead",
    opts = {},
    config = function()
      require("custom.configs.auto-save")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function ()
      require("core.utils").load_mappings "neotree"
    end,
    config = function ()
      require("custom.configs.neo-tree")
    end
  },
  {
    "rmagatti/auto-session",
    config = function()
      local autosession = require("auto-session")
      autosession.setup({})
    end,
    init = function ()
      require("custom.configs.auto-session")
    end
  },
	{
		"aserowy/tmux.nvim",
		event = "VimEnter",
		config = function()
      require("custom.configs.tmux")
		end,
	},
  {
    "ThePrimeagen/harpoon",
    event = "VimEnter",
    config = function()
      require("custom.configs.harpoon")
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = function()
      require("mini.move").setup()
    end,
  },
}

return plugins
