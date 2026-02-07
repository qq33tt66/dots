return {
  "nvim-mini/mini.files",
  config = function()
    require("mini.files").setup({
      {
        mappings = {
          close = "q",
          go_in = "l",
          go_in_plus = "L",
          go_out = "h",
          go_out_plus = "H",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },

        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
        },

        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
      },
    })
  end,
}
