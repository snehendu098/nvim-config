-- Load NvChad's default LSP settings
require("nvchad.configs.lspconfig").defaults()

-- Define LSP servers with their configurations
local servers = {
  "pyright", -- Python
  "ts_ls", -- TypeScript/JavaScript (renamed from tsserver)
  "html", -- HTML
  "cssls", -- CSS,
  "gopls", -- go
  "clangd",
}

-- Enable all basic servers
vim.lsp.enable(servers)

vim.lsp.config("prisma", {
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  root_markers = {
    ".git",
    "package.json",
    "schema.prisma", -- Look for schema.prisma itself
    "prisma", -- Look for prisma directory
  },
  single_file_support = true, -- IMPORTANT: This allows it to work without finding root
  settings = {
    prisma = {
      prismaFmtBinPath = "",
    },
  },
})

-- Enable Prisma
vim.lsp.enable "prisma"

-- Configure Tailwind CSS with special settings for Next.js
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
    },
  },
})

-- Enable Tailwind CSS
vim.lsp.enable "tailwindcss"
-- read :h vim.lsp.config for changing options of lsp servers
