local lsp_list = {
    "rust_analyzer",
    "somesass_ls",
    "kotlin_lsp",
    "pyright",
    "lua_ls",
    "clangd",
    "ts_ls",
    "cssls",
    "gdscript",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = lsp_list,
            automatic_enable = false
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require( "blink.cmp" ).get_lsp_capabilities()

            vim.lsp.config( "*", { capabilities = capabilities } )

            for _, lsp in pairs( lsp_list ) do
                vim.lsp.enable( lsp )
            end

            vim.keymap.set( "n", "K", vim.lsp.buf.hover, {} )
            vim.keymap.set( "n", "<leader>gd", vim.lsp.buf.definition, {} )
            vim.keymap.set( "n", "<leader>gr", vim.lsp.buf.references, {} )
            vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, {} )
        end
    }
}
