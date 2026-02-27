require("mini.move").setup()

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup({
    custom_textobjects = {
        g = function()
            local from = { line = 1, col = 1 }
            local to = {
                line = vim.fn.line("$"),
                col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
        end,
    },
})

require("mini.comment").setup()
require("mini.misc").setup()
require("mini.operators").setup()
require("mini.bufremove").setup()
require("mini.jump").setup()
require("mini.cursorword").setup()
require("mini.trailspace").setup()
require("mini.indentscope").setup()

require("mini.pick").setup({
    options = { use_cache = true },
})
require("mini.extra").setup()
require("mini.files").setup({
    windows = {
        preview = true,
        width_preview = 50,
    },
})

require("mini.visits").setup()
require("mini.sessions").setup()
require("mini.diff").setup({
    source = require("mini.diff").gen_source.save(),
})

require("mini.notify").setup()
require("mini.git").setup()
require("mini.starter").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.misc").setup()

require("mini.keymap").setup()
