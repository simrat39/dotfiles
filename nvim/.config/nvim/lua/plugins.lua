require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- =====================
  -- UI STUFF
  -- =====================

  -- Top buffer/tab line
  use({
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = { "", "" },
          bruh = false,
          tab_size = 22,
          enforce_regular_tabs = true,
          view = "multiwindow",
          show_buffer_close_icons = true,
          diagnostics = "nvim_lsp",
        },
      })
    end,
  })

  use({
    "~/dev/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        show_guides = true,
        symbols = {
          Function = { icon = "[]", hl = "TSFunction" },
        },
      })
    end,
  })

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      -- require("lsp_lines").setup()
    end,
  })

  use({
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<Leader>tt]],
        insert_mappings = false,
      })
    end,
  })

  -- Dracula
  -- use({ "darker-dracula/vim", as = "dracula" })
  use({ "catppuccin/nvim", as = "catppuccin" })
  -- Git in the gutter
  use("lewis6991/gitsigns.nvim")
  -- dev-icons
  use("kyazdani42/nvim-web-devicons")
  -- indent lines
  use("lukas-reineke/indent-blankline.nvim")
  -- statusline
  use({ "feline-nvim/feline.nvim" })
  -- Code actions ui thingy
  use("hood/popui.nvim")
  -- lsp progress thingy
  use("j-hui/fidget.nvim")
  -- startup screen
  use("mhinz/vim-startify")

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
  -- lsp stuff
  -- =====================
  -- lsp stuff
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      -- require("null-ls").setup({
      --   sources = {
      --     require("null-ls").builtins.diagnostics.eslint,
      --   },
      -- })
    end,
  })

  -- completion plugin
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-emoji")
  use("hrsh7th/cmp-nvim-lsp-signature-help")

  -- snips
  use({ "L3MON4D3/LuaSnip", branch="snippet_text_edits" })

  -- tree-sitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground")
  use("windwp/nvim-ts-autotag")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("p00f/nvim-ts-rainbow")

  -- Lua dev
  use("folke/lua-dev.nvim")
  use("ckipp01/stylua-nvim")
  -- flutter
  use("akinsho/flutter-tools.nvim")
  -- ts
  use("jose-elias-alvarez/typescript.nvim")
  -- rust
  use("/home/simrat39/dev/rust-tools.nvim")
  use("/home/simrat39/dev/inlay-hints.nvim")
  use("lvimuser/lsp-inlayhints.nvim")
  -- Debugging
  use("mfussenegger/nvim-dap")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  -- =====================
  -- OTHERS
  -- =====================
  -- Pairs ()
  use("windwp/nvim-autopairs")
  -- which key
  use("anuvyklack/hydra.nvim")
  -- git
  use("tpope/vim-fugitive")
  -- use("antoinemadec/FixCursorHold.nvim")
  -- file trees
  use("kyazdani42/nvim-tree.lua")
  -- surround
  use("tpope/vim-surround")
  -- Comment stuff out
  use("tpope/vim-commentary")
  -- Set root directory properly
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  })
  -- Dev goodies
  use("tpope/vim-scriptease")
  -- Faster stuff lol
  use("lewis6991/impatient.nvim")
  use({
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })

  use("p00f/cphelper.nvim")
  use({
    "~/dev/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          require("sim_config.hover_actions")
          -- require("hover.providers.lsp")
          -- require("hover.providers.gh")
          -- require("hover.providers.man")
          -- require("hover.providers.dictionary")
        end,
        preview_opts = {
          border = nil,
        },
        title = false,
      })

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, {
        desc = "hover.nvim",
      })
      vim.keymap.set(
        "n",
        "gK",
        require("hover").hover_select,
        { desc = "hover.nvim (select)" }
      )
    end,
  })
  -- formatter
  use({
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          javascriptreact = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  vim.api.nvim_buf_get_name(0),
                },
              }
            end,
          },
          javascript = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
          css = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = {
                  "--stdin-filepath",
                  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  })
end)
