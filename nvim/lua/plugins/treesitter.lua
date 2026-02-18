require("nvim-treesitter").setup({
    ensure_installed = {
        "lua",
        "c",
        "cpp",
        "go",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "python",
        "json",
        "bash",
        "yaml",
        "toml",
        "markdown",
    },

    auto_install = true,

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    },
})
