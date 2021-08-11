require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- =====================
    -- UI STUFF
    -- =====================
    -- Statusline
    use 'glepnir/galaxyline.nvim'
    -- Top buffer/tab line
    use 'akinsho/nvim-bufferline.lua'
    -- Dracula
    use {'dracula/vim', as = 'dracula'}
    -- Git in the gutter
    use 'lewis6991/gitsigns.nvim'
    -- dev-icons
    use 'kyazdani42/nvim-web-devicons'
    -- UI stuff (mainly used for lsp overrides)
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    -- Trouble
    use 'folke/trouble.nvim'
    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- =====================
    -- TELESCOPE
    -- =====================
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'}}
    }
    use {
        'romgrk/fzy-lua-native',
        requires = {{'nvim-telescope/telescope.nvim'}}
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = {{'nvim-telescope/telescope.nvim'}}
    }

    -- =====================
    -- Coding stuff
    -- =====================
    -- lsp stuff
    use 'neovim/nvim-lspconfig'
    -- completion plugin
    use 'hrsh7th/nvim-compe'
    -- tree-sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'windwp/nvim-ts-autotag'
    -- Lua dev
    use 'folke/lua-dev.nvim'
    -- flutter
    use 'akinsho/flutter-tools.nvim'
    -- snippets
    use 'hrsh7th/vim-vsnip'
    -- dart snippets
    use 'Nash0x7E2/awesome-flutter-snippets'
    -- Formats lua
    use 'andrejlevkovitch/vim-lua-format'
    -- Ranger
    use {'kevinhwang91/rnvimr', run = ':make sync'}
    -- Comment stuff out
    use 'tpope/vim-commentary'
    -- Set root directory properly
    use 'airblade/vim-rooter'
    -- Show a popup with signature info
    use "ray-x/lsp_signature.nvim"
    -- Debugging
    use 'mfussenegger/nvim-dap'
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    -- idk
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    -- =====================
    -- OTHERS
    -- =====================
    -- Discord
    use 'andweeb/presence.nvim'
    -- Pairs ()
    use 'windwp/nvim-autopairs'
    -- Startify (Dashboard thingy)
    use 'mhinz/vim-startify'
    -- Which key
    use 'liuchengxu/vim-which-key'
    -- git
    use 'tpope/vim-fugitive'
    -- file trees
    use 'kyazdani42/nvim-tree.lua'
    use 'preservim/nerdtree'
    -- tpope
    use 'tpope/vim-surround'
end)