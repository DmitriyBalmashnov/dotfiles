vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.spell = true
vim.opt_local.conceallevel=2


local group = vim.api.nvim_create_augroup("MarkdownPDF", { clear = false })
-- 2. Define the Autocommand
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    buffer = 0, -- the current buffer only
    callback = function()
        -- Determine the output name (replaces .md with .pdf)
        local pdf_name = vim.fn.expand("%:r") .. ".pdf"
        
        -- Run pandoc in the background (async)
        vim.fn.jobstart({
            "pandoc",
            vim.fn.expand("%"),
            "--pdf-engine=tectonic",
            "-V", "geometry:margin=1in",
            "-o",
            pdf_name
        }, {
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify("pdf updated", vim.log.levels.INFO)
                else
                    vim.notify("pandoc failed(" .. code .. ")", vim.log.levels.ERROR)
                end
            end
        })
    end,
})
