local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp, luasnip = require("cmp"), require("luasnip")
    local select = cmp.SelectBehavior.Select
    cmp.setup({
      experimental = { ghost_text = true },
      window = {
        completion = {
          -- border = moduleObject.styles.border,
          -- winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
        documentation = {
          border = moduleObject.styles.border,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
          keyword_length = 2,
        },
        { name = "path" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- item.kind = string.format("%s %s", I.lsp.kinds[item.kind:lower()], item.kind)
          item.kind = string.format("%s ", I.lsp.kinds[item.kind:lower()])
          item.menu = ({
            luasnip = "[Snip]",
            nvim_lsp = "[LSP]",
            buffer = "[Buf]",
            path = "[Path]",
            cmdline = "[Cmd]",
          })[entry.source.name] or entry.source.name
          return item
        end,
      },
      mapping = {
        ["<M-l>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = select })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<M-h>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = select })
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
        ["<C-e>"] = { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-8), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(8), { "i", "c" }),
        -- ["<C-space>"] = cmp.mapping.complete(),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = select }), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = select }), { "i", "c" }),
      },
    })
  end,
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    -- "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      keys = {
        {
          "<C-o>",
          function()
            if require("luasnip").choice_active() then
              require("luasnip").change_choice(1)
            end
          end,
          mode = { "s", "i" },
          desc = "Select option",
        },
      },
      opts = function()
        local types = require("luasnip.util.types")

        return {
          region_check_events = "CursorMoved,CursorHold,InsertEnter",
          delete_check_events = "InsertLeave",
          enable_autosnippets = true,
          ext_opts = {
            [types.choiceNode] = {
              active = {
                virt_text = {
                  { I.misc.snow .. " ", "Type" },
                },
              },
            },
          },
        }
      end,
      config = function(_, opts)
        require("luasnip").setup(opts)
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = vim.fn.stdpath("config") .. "/snippets",
        })
      end,
    },
  },
}

return M
