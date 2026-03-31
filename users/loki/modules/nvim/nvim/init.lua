vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }

vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.breakindent = true
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80
vim.opt.sidescrolloff = 8

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", ":w!<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>v", "V%", { silent = true })
vim.keymap.set("n", "<leader>oo", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
vim.keymap.set("n", "<leader>on", ":lua vim.diagnostic.goto_next()<CR>", { silent = true })
vim.keymap.set("n", "<leader>oN", ":lua vim.diagnostic.goto_prev()<CR>", { silent = true })

-- tabs
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", "gt", { silent = true })
vim.keymap.set("n", "<leader>j", "gT", { silent = true })


vim.pack.add({ "https://github.com/RedsXDD/neopywal.nvim" }, { confirm = false })
require("neopywal").setup({
    transparent_background = true,
    plugins = {
        notify = false,
    },
})
vim.cmd.colorscheme("neopywal")

-- tree sitter
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })
-- require("nvim-treesitter.install").update("all")

-- tree view
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})
require("nvim-tree").setup({
  view = {
    width = 25,
  },
})
vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { silent = true })

-- auto completion and lsp
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })
require("blink.cmp").setup({
  completion = {
    documentation = { auto_show = true, },
  },
  keymap = {
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
  },

  fuzzy = {
    implementation = "lua",
  },
})

local lsp_servers = {
  lua_ls = {
    cmd = { "/etc/profiles/per-user/loki/bin/lua-language-server" },
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file("lua", true),
        },
      },
    },
  },
  qmlls = {
    cmd = { "/etc/profiles/per-user/loki/bin/qmlls" },
  },
}

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig", }, { confirm = false })

for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, vim.tbl_extend("force", config, {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, {
        buffer = bufnr,
        desc = "Go to definition",
      })

      vim.keymap.set("n", "grf", vim.lsp.buf.format, {
        buffer = bufnr,
        desc = "Format",
      })
    end,
  }))

  vim.lsp.enable(server)
end

-- INFO: fuzzy finder
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim"
}, { confirm = false })

require("telescope").setup({})

local pickers = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", pickers.find_files, { desc = "[F]ind [F]iles", })
vim.keymap.set("n", "<leader>fg", pickers.grep_string, { desc = "[F]ind [W]ord", })

-- vim.pack.update()

