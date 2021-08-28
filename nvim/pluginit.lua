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

require('telescope').setup({
	defaults = {
		mappings = {
			i = {
					["<C-Down>"] = require('telescope.actions').cycle_history_next,
					["<C-Up>"] = require('telescope.actions').cycle_history_prev,
			}
		}
	}
})


-- shade

shade = require('shade')
shade.setup({
	overlay_opacity = 50,
	opacity_step = 1,
	keys = {
		brightness_up    = '<C-Up>',
		brightness_down  = '<C-Down>',
		toggle           = '<Leader>ts',
	}
})
shade.disable()


-- gitsigns

gitsigns = require('gitsigns')
gitsigns.setup {
	update_debounce = 500,
}
gitsigns.detach_all()


-- highlights

theme = require('monokai')
theme.highlight('GitSignsChange',   { fg = theme.classic.diff_change_fg })
theme.highlight('GitSignsAdd',      { fg = theme.classic.diff_add_fg })
theme.highlight('GitSignsDelete',   { fg = theme.classic.diff_remove_fg })
theme.highlight('GitSignsChangeNr', { fg = theme.classic.diff_change_fg })
theme.highlight('GitSignsAddNr',    { fg = theme.classic.diff_add_fg })
theme.highlight('GitSignsDeleteNr', { fg = theme.classic.diff_remove_fg })

theme.highlight('CursorLine',     { sp = theme.classic.base5, style = 'underline' })
