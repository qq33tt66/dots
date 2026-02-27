require("conform").setup({
    formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
    },
})
