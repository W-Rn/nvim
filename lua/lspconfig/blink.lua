return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      -- "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function() --禁用指定文件类型
        return not vim.tbl_contains({ "text", "markdown" }, vim.bo.filetype)
      end,
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        -- Show/Remove completion
        ["<A-n>"] = {
          function(cmp)
            cmp.show { providers = { "buffer" } }
          end,
        },
      },
      cmdline = { enabled = false },
      sources = {
        default = function()
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          else
            return { "lsp", "path", "snippets", "buffer" }
            -- return { "lsp", "path", "buffer" }
          end
        end,
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lsp = {
            name = "LSP",
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
              end, items)
            end,
            score_offset = 1000,
            fallbacks = { "buffer" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 960,
          },
          path = {
            name = "Path",
            score_offset = 900,
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
          buffer = {
            score_offset = 800,
          },
          snippets = {
            name = "Snippets",
            score_offset = 950,
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
            fallbacks = { "buffer" },
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          -- defaults
          "score",
          "sort_text",
        },
      },

      completion = {
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
          auto_show = true,
          border = "rounded",
          -- scrolloff = 5,
          scrollbar = false,
          max_height = 15,
          -- winhighlight = "",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "kind" }, { "source_name" } },
            treesitter = { "lsp", "snippets", "path" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
            scrollbar = false,
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          scrollbar = false,
          show_documentation = false,
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LoadTheme",
        callback = function()
          vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#DA70D6" })
          vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#4682B4" })
          vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#1F4F42" })
          vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#4682B4" })
          vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = "#4682B4" })
          vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#4682B4" })
          vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { bg = "#1F4F42", bold = true })
        end,
      })
    end,
  },
}
