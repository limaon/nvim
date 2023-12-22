local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = function()
    local cmp, luasnip = require("cmp"), require("luasnip")
    local select = cmp.SelectBehavior.Select

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
          == nil
    end

    return {
      global = {
        preselect = cmp.PreselectMode.Item,
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
        sources = {
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip", group_index = 1 },
          { name = "path", group_index = 1 },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
            keyword_length = 2,
            group_index = 2,
          },
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, item)
            if item.kind and I.lsp.kinds[item.kind:lower()] then
              item.kind = string.format("%s %s", I.lsp.kinds[item.kind:lower()], item.kind)
            end
            if item.abbr then
              if string.len(item.abbr) > 20 then
                item.abbr = string.sub(item.abbr, 1, 17) .. "... "
              end
            else
              item.abbr = ""
            end

            return item
          end,
        },
        mapping = {
          ["<TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = select })
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = select })
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
          ["<C-e>"] = { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-8), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(8), { "i", "c" }),
          -- ["<C-c>"] = cmp.mapping.complete(),
          ["<C-n>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = select }),
            { "i", "c" }
          ),
          ["<C-p>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = select }),
            { "i", "c" }
          ),
        },
      },
      -- filetype = {},
      -- buffer = {}
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")

    for key, value in pairs(opts) do
      if key == "global" then
        cmp.setup(value)
      else
        for _, v in ipairs(value) do
          cmp.setup[key](v[1], v[2])
        end
      end
    end
  end,
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-cmdline",
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
          delete_check_events = "TextChanged",
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
