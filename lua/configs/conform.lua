local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    -- js/ts
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- prisma
    prisma = { "prisma" },

    -- python
    python = { "black" },

    -- go
    go = { "gopls" }, -- ADD THIS

    -- c/cpp
    c = { "clang_format" }, -- ADD THIS
    cpp = { "clang_format" },
  },

  format_on_save = {
    --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
