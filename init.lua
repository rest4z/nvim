vim.g.mapleader = " "
-- add line when pressing ESC
vim.api.nvim_set_keymap('n', '<Enter>', 'o<Esc>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-CR>', 'O<Esc>', { noremap = true, silent = true })

-- Leader key mappings
vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree toggle<CR>', { noremap = true, silent = true })  -- Toggle NeoTree
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- Save file
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })  -- Quit file
vim.api.nvim_set_keymap('n', '<leader>e', ':wq<CR>', { noremap = true, silent = true })  -- save and quit file

vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })  -- vertical split
vim.api.nvim_set_keymap('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })  -- horizontal split

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })  -- move to left split
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })  -- move to bottom split
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })  -- move to top split
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })  -- move to right split

vim.api.nvim_set_keymap('n', '<leader>a', 'gg0vG$', { noremap = true, silent = true })  -- copy all file

vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true }) -- Delete without yanking
vim.keymap.set("x", "x", '"_x', { noremap = true, silent = true }) -- Delete without yanking
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true }) -- Paste without overwriting register--vim.clipboard

--sync OS and vim clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.tabstop = 4
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching 
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Hide mouse cursor
vim.opt.mouse = ""

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.undolevels = 5000
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.scrolloff = 10

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--line numbers
vim.wo.number = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end 
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {"go", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"},

        auto_install = true,

        highlight = {
          enable = true,
        },
      })
    end,
  },
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{ "nyoom-engineering/oxocarbon.nvim", priority = 1000 },
{ "rebelot/kanagawa.nvim", priority = 1000 },
{ "navarasu/onedark.nvim", priority = 1000 },
{ "sho-87/kanagawa-paper.nvim", priority = 1000 },
{

	--autocomplete
		'neovim/nvim-lspconfig',
		dependencies = 'hrsh7th/cmp-nvim-lsp',
		config = function()

			local lspconfig_defaults = require('lspconfig').util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lspconfig_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			local lspconfig = require('lspconfig')
			lspconfig.zls.setup({})
			lspconfig.hls.setup({
				-- TODO: figure out how to disable certain hints
			})
			lspconfig.golangci_lint_ls.setup({})
			lspconfig.asm_lsp.setup({})
			lspconfig.bashls.setup({})
			lspconfig.ocamllsp.setup({})
			lspconfig.clangd.setup({})
			lspconfig.nixd.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.emmet_ls.setup({})
			lspconfig.rust_analyzer.setup({})
			lspconfig.jdtls.setup({})
			lspconfig.pylsp.setup({})
		end,
		ft = {
			'go',
			'zig',
			'haskell',
			'asm',
			'sh',
			'ocaml',
			'c', 'cpp',
			'nix',
			'lua',
			'html', 'js', 'php',
			'rust',
			'java',
			'python',
		},
		keymaps = {
			{ 'gd',        mode = 'n',        '<cmd>lua vim.lsp.buf.definition()<cr>',           desc = 'lsp: Go to definition of symbol' },
			{ 'gD',        mode = 'n',        '<cmd>lua vim.lsp.buf.declaration()<cr>',          desc = 'lsp: Go to declaration of symbol' },
			{ 'gi',        mode = 'n',        '<cmd>lua vim.lsp.buf.implementation()<cr>',       desc = 'lsp: Go to implementation of symbol' },
			{ 'go',        mode = 'n',        '<cmd>lua vim.lsp.buf.type_definition()<cr>',      desc = 'lsp: Go to type definition of symbol' },
			{ 'gr',        mode = 'n',        '<cmd>lua vim.lsp.buf.references()<cr>',           desc = 'lsp: Find references of symbol' },
			{ 'gs',        mode = 'n',        '<cmd>lua vim.lsp.buf.signature_help()<cr>',       desc = 'lsp: Show signature help for function' },
			{ '<F2>',      mode = 'n',        '<cmd>lua vim.lsp.buf.rename()<cr>',               desc = 'lsp: Rename symbol under cursor' },
			{ '<F3>',      mode = {'n', 'x'}, '<cmd>lua vim.lsp.buf.format({async = true})<cr>', desc = 'lsp: Format buffer (async)' },
			{ '<F4>',      mode = 'n',        '<cmd>lua vim.lsp.buf.code_action()<cr>',          desc = 'lsp: Show code actions for symbol' },
		},
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = 'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				sources = {
					{name = 'nvim_lsp'},
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = require('cmp').mapping.preset.insert({}),

			})
		end,
	},
	{
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
	},
	{
		-- Configuring signs through nvim doesn't work so I have to use this
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		lazy = false,
		config = function()
			local lsp_zero = require('lsp-zero')
			lsp_zero.ui({
				float_border = 'rounded',
				sign_text = {
					error = '✘',
					warn = '▲',
					hint = '⚑',
					info = '»',
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require('telescope').setup{}
		end
	}

})

-- :colorscheme 'theme' to preview !
-- vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd.colorscheme("kanagawa-wave")

require("neo-tree").setup({
event_handlers = {

  {
    event = "file_open_requested",
    handler = function()
      -- auto close
      require("neo-tree.command").execute({ action = "close" })
    end
  },

}
})

require("mason").setup()

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
	desc = 'Set indentation settings for curly brace languages',
	pattern = { '*.c','*.cc','*.cpp','*.h','*.hh','*.hpp','*.lua','*.js','*.php','*.sh','.y','.yy','.l','.ll','*.java' },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.cindent = true
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	end,
})

-- telescope key bindings / shortcut
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

