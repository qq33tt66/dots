require("blink.cmp").setup({
  completion = {
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      border = "rounded",
      draw = {
        -- This creates the VS Code layout: [Icon] [Name] ... [Description]
        columns = { { "kind_icon", "label", gap = 1 }, { "kind", "source_name", gap = 1 } },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              local lspkind = require("lspkind")
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                -- Use lspkind to get the exact VS Code style icons
                icon = lspkind.symbol_map[ctx.kind] or icon
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_hl then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
          -- This displays the "For-In Loop" or "child_process" text on the right
          kind = {
            ellipsis = true,
            width = { fill = true }, -- This pushes it to the far right
            text = function(ctx)
              return ctx.kind
            end,
          },
        },
      },
    },
    -- Show documentation window just like VS Code does on hover/selection
    documentation = {
      auto_show = true,
      window = { border = "rounded" },
    },
  },
  keymap = {
    preset = "enter",
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
