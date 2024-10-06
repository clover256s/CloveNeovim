local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use({ "williamboman/mason.nvim" })
  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  use({ "stevearc/conform.nvim" })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  use({
    "goolord/alpha-nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
  })
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })
  use 'windwp/nvim-ts-autotag'
  use "lukas-reineke/indent-blankline.nvim"
  use 'bluz71/vim-nightfly-colors'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
  use {
    'maxmx03/solarized.nvim',
    config = function()
      vim.o.background = 'dark'
      ---@type solarized
      local solarized = require('solarized')
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      solarized.setup({})
      vim.cmd.colorscheme 'solarized'
    end
  }
  if packer_bootstrap then
    require("packer").sync()
  end
end)
