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
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      require("core.utils").load_mappings "rust"
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function ()
      require("custom.configs.rust-tools")
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function ()
      require("custom.configs.dap-ui")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
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
  {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("custom.configs.copilot")
  end,
  },
  {
  'mrcjkb/haskell-tools.nvim',
  version = '^3', -- Recommended
  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  }
}

return plugins
