-- treesitter

require('nvim-treesitter.configs').setup {
	-- Modules and its options go here
	highlight = { enable = true },
	textobjects = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
}


-- telescope

local telescope = require('telescope')
telescope_actions = require('telescope.actions')
telescope_builtin = require('telescope.builtin')
telescope.setup({
	defaults = {
		mappings = {
			i = {
					["<C-Down>"]  = telescope_actions.cycle_history_next,
					["<C-Up>"]    = telescope_actions.cycle_history_prev,
					["<M-r>"]     = telescope_actions.to_fuzzy_refine,
					["<C-space>"] = nil,
			}
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
		},
        file_browser = {
            mappings = {
                ["i"] = {
                    ["<C-t>"] = telescope_actions.file_tab
                }
            }
        }
	}
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')

require("which-key").setup {
	triggers = {'<leader>'}
    -- hide_statusline = false,
    -- default_keymap_settings = {
    --     silent=true,
    --     noremap=true,
    -- },
    -- default_mode = 'n',
}

gitsigns = require('gitsigns')
gitsigns.setup {
	update_debounce = 500,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
		  opts = opts or {}
		  opts.buffer = bufnr
		  vim.keymap.set(mode, l, r, opts)
		end

		map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
		map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

		-- Actions
		map({'n', 'v'}, '<leader>ghs', ':Gitsigns stage_hunk<CR>')
		map({'n', 'v'}, '<leader>ghr', ':Gitsigns reset_hunk<CR>')
		map('n', '<leader>ghu', gs.undo_stage_hunk)
		map('n', '<leader>ghp', gs.preview_hunk)
		map('n', '<leader>gtb', gs.toggle_current_line_blame)
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}


-- comment

require('Comment').setup()


-- Highlights
monokai = require('monokai')
local palette = monokai.classic
monokai.setup {
	custom_hlgroups = {


	GitSignsChange     = { fg = palette.diff_change },
	GitSignsAdd        = { fg = palette.diff_add },
	GitSignsDelete     = { fg = palette.diff_remove },
	GitSignsChangeNr   = { fg = palette.diff_change },
	GitSignsAddNr      = { fg = palette.diff_add },
	GitSignsDeleteNr   = { fg = palette.diff_remove },
	CursorLine         = { sp = palette.base5, style = 'underline' },
	ColorColumn        = { sp = palette.base5, style = 'underline' },
	Constant           = { fg = palette.purple },
	TSConstant         = { fg = palette.purple },
	["@function.call"] = { fg = palette.green, style = 'italic' },
	["@text.todo"]     = { fg = palette.orange, style = 'bold' },
	["@todo"]          = { fg = palette.orange, style = 'bold' },
	["@constant"]      = { fg = palette.purple },
	["@include"]       = { fg = palette.pink, style = 'italic' },
	["@define"]        = { fg = palette.pink, style = 'italic' },
	["@preproc"]       = { fg = palette.pink, style = 'bold' },
	Tabline            = { bg = palette.base5, },
	TablineFill        = { bg = palette.base5, },
	TabLineSel         = { bg = palette.base2, },


	}
}


-- require'lsp_signature'.setup(cfg)

-- Setup nvim-cmp.
local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.config.disable,
		['<C-f>'] = cmp.config.disable,
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-k>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
		['<C-y>'] = cmp.config.disable,
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		-- { name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_default_capabilities = function()
	-- Use default vim.lsp capabilities and apply some tweaks on capabilities.completion for nvim-cmp
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require('cmp_nvim_lsp').default_capabilities(capabilities))
	-- [Additional capabilities customization]
	-- Large workspace scanning may freeze the UI; see https://github.com/neovim/neovim/issues/23291
	capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
	return capabilities
end

require('lspconfig')['clangd'].setup {
	filetypes = { 'c', 'cpp' },
	root_dir = require('lspconfig').util.root_pattern('compile_commands.json'),
	autostart = false,
	cmd = { 'cclangd', 'clangd' },
	capabilities = lsp_default_capabilities()
}
require('lspconfig')['pylsp'].setup {
	-- capabilities = lsp_default_capabilities()
}
require('lspconfig')['ccls'].setup {
	filetypes = {'c'},
	autostart = false,
	-- capabilities = lsp_default_capabilities()
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single"
  }
)

local function map(mode, l, r, opts)
	opts = opts or {}
	opts.buffer = bufnr
	opts.silent = (opts.silent == nil) or opts.silent
	vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>k', vim.lsp.buf.hover)
map('n', '<leader>lr', vim.lsp.buf.rename)
-- map('n', '<leader>lq', vim.diagnostic.set_qflist)
map('n', '<leader>ln', vim.diagnostic.goto_next)
map('n', '<leader>lp', vim.diagnostic.goto_prev)
map('n', '<leader>ll', '<cmd>tab split \\| lua vim.lsp.buf.definition()<CR>', {expr=true})
