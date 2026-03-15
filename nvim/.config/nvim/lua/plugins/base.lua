return {
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        branch= 'master',
        lazy= false,
        build= ":TSUpdate",
        config = function() require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "lua", "markdown"},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {enable = true},
        }) end,
    },
    -- colorscheme
    {
        'rose-pine/neovim', 
        as = 'rose-pine', 
        config = function() vim.cmd('colorscheme rose-pine') end
    },
    --lang-server-installer - mason
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            {
                'mason-org/mason.nvim',
                opts= {}
            },
            {'neovim/nvim-lspconfig'},
        },
    },

    --auxillary
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    {'nvim-telescope/telescope.nvim', tag='0.1.8', requires = {'nvim-lua/plenary.nvim'}},
}
