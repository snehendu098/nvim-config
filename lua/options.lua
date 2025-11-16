require "nvchad.options"

-- add yours here!

local opt = vim.o
opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- o.cursorlineopt ='both' -- to enable cursorline!
