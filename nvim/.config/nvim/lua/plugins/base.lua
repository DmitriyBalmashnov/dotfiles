return {
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        lazy= false,
        build= ":TSUpdate",
        branch= "main",
        config = function()
        require("nvim-treesitter").install {
            "python",
            "lua",
            "markdown",
            "markdown_inline"
        }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '<filetype' },
            callback = function() vim.treesitter.start() end,
        })

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
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
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    {'nvim-telescope/telescope.nvim', tag='0.1.8', requires = {'nvim-lua/plenary.nvim'}},
}
