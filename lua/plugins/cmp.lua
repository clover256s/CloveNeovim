local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰡱",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰬴",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

cmp.setup({
  view = {
    entries = { name = "custom", selection_order = "near_cursor" }, -- can be "custom", "wildmenu" or "native"
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]

      local fixed_width = fixed_width or false
      local content = vim_item.abbr

      if fixed_width then
        vim.o.pumwidth = fixed_width
      end

      local win_width = vim.api.nvim_win_get_width(0)
      local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.3)
      if #content > max_content_width then
        vim_item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
      else
        vim_item.abbr = content .. (" "):rep(max_content_width - #content)
      end
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),        -- 将 <Tab> 键映射为选择下一个补全项
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- 将 <S-Tab> 键映射为选择上一个补全项
    ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- 将 <C-f> 键映射为向下滚动文档
    ["<C-Space>"] = cmp.mapping.complete(),            -- 将 <C-Space> 键映射为触发补全
    ["<C-e>"] = cmp.mapping.abort(),                   -- 将 <C-e> 键映射为中止补全
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 将 <CR> 键映射为确认当前选择的项
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local lsp_servers = {
  "clangd",        -- C/C++
  "cmake",         -- cmake
  "rust_analyzer", -- rust_analyzer
  "bashls",        -- Bash
  "cssls",         -- CSS
  "html",          -- HTML
  "jsonls",        -- JSON
  "lua_ls",        -- Lua
  "marksman",      -- Markdown
  "ts_ls",         -- TypeScript/JavaScript
}

for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
  })
end
