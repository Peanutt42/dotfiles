-- Set leader key
vim.g.mapleader = " "

-- Install Lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "nvim-telescope/telescope.nvim"
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP source
      "hrsh7th/cmp-buffer",      -- buffer words
      "hrsh7th/cmp-path",        -- file paths
      "L3MON4D3/LuaSnip",        -- snippet engine (required)
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
  },
  {
    name = "github-dark-contrast",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
	config = function()
      require("github_dark_contrast").setup()
    end,
  },
}, {
  ui = { border = "rounded" },
  checker = { enabled = false },
})

-- Basics
vim.o.number = true
vim.o.relativenumber = false
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd([[
  filetype plugin indent on
]])
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"

-- LSP setup
-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls" },
})

-- Default LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Modern setup: mason-lspconfig auto-starts LSPs via handlers
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local config = {
        capabilities = capabilities,
      }

      -- Special settings for Lua
      if server_name == "lua_ls" then
        config.settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        }
      end

      vim.lsp.config[server_name] = config
      vim.lsp.start(config)
    end,
  },
})

-- Autocomplete lsp setup
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nixd lsp setup:
vim.lsp.enable('nixd')


-- rust-analyzer cant access system cargo
if vim.lsp.config.rust_analyzer then
  vim.lsp.config.rust_analyzer.cmd = { "rust-analyzer" } -- skip cargo root detection
  vim.lsp.config.rust_analyzer.capabilities = cmp_capabilities;
end




vim.api.nvim_create_augroup("RustTabs", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})



local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>b", function() vim.cmd [[Neotree position=right toggle]] end)
vim.keymap.set("n", "<leader>t", function() vim.cmd [[ToggleTerm]] end)


-- inline diagnostic error messages
vim.diagnostic.enable()
vim.diagnostic.config({ virtual_text = true, virtual_lines = true, update_in_insert = true })



-- haskell
local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
