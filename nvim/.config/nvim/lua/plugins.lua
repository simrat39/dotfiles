require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- =====================
  -- UI STUFF
  -- =====================
  -- Top buffer/tab line
  use("akinsho/nvim-bufferline.lua")
  -- Dracula
  use({ "darker-dracula/vim", as = "dracula" })
  -- use("~/dev/darker-dracula/vim")
  -- Git in the gutter
  use("lewis6991/gitsigns.nvim")
  -- dev-icons
  use("kyazdani42/nvim-web-devicons")
  -- UI stuff (mainly used for lsp overrides)
  use("RishabhRD/popfix")
  use("RishabhRD/nvim-lsputils")
  -- Trouble
  use("folke/trouble.nvim")
  -- Colorizer
  use("norcalli/nvim-colorizer.lua")
  -- indent lines
  use("lukas-reineke/indent-blankline.nvim")
  -- statusline
  use({ "famiu/feline.nvim", branch = "develop" })

  use("tpope/vim-scriptease")

  -- =====================
  -- TELESCOPE
  -- =====================
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
  })
  use({
    "romgrk/fzy-lua-native",
    requires = { { "nvim-telescope/telescope.nvim" } },
  })
  use({
    "nvim-telescope/telescope-fzy-native.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  })

  -- =====================
  -- Coding stuff
  -- =====================
  -- lsp stuff
  use("neovim/nvim-lspconfig")

  -- completion plugin
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/cmp-emoji")

  use("L3MON4D3/LuaSnip")

  use("williamboman/nvim-lsp-installer")

  -- tree-sitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground")
  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- Lua dev
  use("folke/lua-dev.nvim")
  use("ckipp01/stylua-nvim")
  -- flutter
  use("akinsho/flutter-tools.nvim")
  -- snippets
  use("hrsh7th/vim-vsnip")
  -- dart snippets
  use("Nash0x7E2/awesome-flutter-snippets")
  -- Ranger
  use({ "kevinhwang91/rnvimr", run = ":make sync" })
  -- Comment stuff out
  use("tpope/vim-commentary")
  -- Set root directory properly
  use("airblade/vim-rooter")
  -- Show a popup with signature info
  use("ray-x/lsp_signature.nvim")
  -- Debugging
  use("mfussenegger/nvim-dap")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- idk
  use("jose-elias-alvarez/null-ls.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  -- rust
  use("/home/simrat39/dev/rust-tools.nvim")

  -- =====================
  -- OTHERS
  -- =====================
  -- Discord
  use("andweeb/presence.nvim")
  -- Pairs ()
  use("windwp/nvim-autopairs")
  -- Startify
  use("mhinz/vim-startify")
  -- Which key
  use("liuchengxu/vim-which-key")
  -- git
  use("tpope/vim-fugitive")
  use("antoinemadec/FixCursorHold.nvim")
  -- file trees
  use("kyazdani42/nvim-tree.lua")
  -- tpope
  use("tpope/vim-surround")
end)
