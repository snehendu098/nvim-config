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
  "prisma",
  "rust_analyzer",
  "dockerls", -- Dockerfile
  "bashls", -- Shell scripts
  "yamlls", -- Kubernetes/YAML
  "terraformls", -- Terraform
}

-- Enable all basic servers
vim.lsp.enable(servers)

-- Enhanced Kubernetes YAML configuration
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
      format = { enable = true },
      validate = true,
      completion = true,
      hover = true,
    },
  },
})

vim.lsp.enable "yamlls"

-- Terraform configuration
vim.lsp.config("terraformls", {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "terraform-vars" },
})

vim.lsp.enable "terraformls"

-- Bash LSP configuration
vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

vim.lsp.enable "bashls"

-- Dockerfile LSP
vim.lsp.enable "dockerls"

-- Enhanced rust-analyzer configuration (optional but recommended)
-- Project-aware: Anchor/Solana projects get `idl-build` feature,
-- everything else (foundry, generic Rust) gets all features.
-- Switching projects in one session: run `:LspRestart` to re-evaluate.
local function rust_analyzer_settings()
  local bufname = vim.api.nvim_buf_get_name(0)
  local start = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
  local anchor_root = vim.fs.find({ "Anchor.toml" }, { upward = true, path = start })[1]

  local cargo_cfg = {
    buildScripts = { enable = true },
    loadOutDirsFromCheck = true,
  }

  if anchor_root then
    cargo_cfg.features = { "idl-build" }
  else
    cargo_cfg.allFeatures = true
  end

  return {
    ["rust-analyzer"] = {
      cargo = cargo_cfg,
      checkOnSave = true,
      check = { command = "clippy" },
      procMacro = { enable = true },
      diagnostics = {
        enable = true,
        experimental = { enable = true },
        disabled = { "unresolved-proc-macro" },
      },
      hover = {
        actions = {
          enable = true,
          references = { enable = true },
        },
      },
      inlayHints = {
        enable = true,
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        closureReturnTypeHints = { enable = "always" },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  }
end

vim.lsp.config("rust_analyzer", {
  cmd = { "rustup", "run", "stable", "rust-analyzer" },
  settings = rust_analyzer_settings(),
})

vim.lsp.enable "rust_analyzer"

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
