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

    -- python
    python = { "black" },

    -- go
    go = { "gopls" }, -- ADD THIS

    -- c/cpp
    c = { "clang_format" }, -- ADD THIS
    cpp = { "clang_format" },

    rust = { "rustfmt" }, -- ADD THIS

    -- DevOps / Infrastructure
    sh = { "shfmt" }, -- Shell scripts
    bash = { "shfmt" }, -- Bash scripts
    terraform = { "terraform_fmt" }, -- Terraform
    tf = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
    dockerfile = { "hadolint" }, -- Dockerfile linter (optional)
  },

  format_on_save = {
    --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- Configure formatters
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" }, -- 2 space indent, indent switch cases
    },
    terraform_fmt = {
      command = "terraform",
      args = { "fmt", "-" },
      stdin = true,
    },
  },
}

return options
