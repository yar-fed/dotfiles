WORKDIR = '~/git/WORKDIR'

local wk = require('which-key')

local function telescope_buf_cwd()
	return string.len(vim.fn.expand("%:h")) > 0 and vim.fn.expand("%:h") or vim.fn.getcwd()
end

wk.register({
	f = {
		name = '+telescope file_local',
		e = {function() require'telescope'.extensions.file_browser.file_browser({cwd = telescope_buf_cwd()}) end, 'file_browser'},
		w = {
			name = '+<cword>',
			r = {function() telescope_builtin.live_grep({cwd = telescope_buf_cwd(), default_text = vim.fn.expand("<cword>")}) end, 'live_grep'},
		},
		r = {function() telescope_builtin.live_grep({cwd = telescope_buf_cwd()}) end, 'live_grep'},
	},
	g = {
		name = '+telescope cwd based',
		e = {function() require'telescope'.extensions.file_browser.file_browser() end, 'file_browser'},
		w = {
			name = '+<cword>',
			r = {function() telescope_builtin.live_grep({default_text = vim.fn.expand("<cword>")}) end, 'live_grep'},
		},
		r = {function() telescope_builtin.live_grep() end, 'live_grep'},
	},
	p = {
		name = '+WORKDIR',
		f = {function() telescope_builtin.git_files({cwd = WORKDIR, show_untracked = true}) end, 'git files'},
		g = {
			name = '+git',
			l = {
				name = '+log',
				g = {function() telescope_builtin.git_commits({cwd = WORKDIR}) end, 'full history'},
				f = {function() telescope_builtin.git_bcommits({cwd = WORKDIR}) end, 'current buffer history'},
				l = {function() telescope_builtin.git_bcommits({cwd = WORKDIR}) end, 'current selection history'},
			},
			b = {function() telescope_builtin.git_branches({cwd = WORKDIR}) end, 'branches'},
			s = {function() telescope_builtin.git_status({cwd = WORKDIR, layout_config = {preview_width = 0.7}}) end, 'status'},
		}
	},
    l = {
		name = '+lsp',
		j = {function() telescope_builtin.lsp_references({include_current_line = true, jump_type = 'never'}) end, 'references'},
        d = {function() telescope_builtin.lsp_definitions({include_current_line = true, jump_type = 'split'}) end, 'split definition'},
        l = {function() telescope_builtin.lsp_definitions({include_current_line = true, jump_type = 'tab'}) end, 'tab definition'},
        k = {function() telescope_builtin.lsp_document_symbols({ignore_symbols = {"field"}}) end, 'document symbols'},
        e = {function() telescope_builtin.lsp_dynamic_workspace_symbols({ignore_symbols = {"field"}}) end, 'workspace symbols'},
        
    },
    d = {function() telescope_builtin.lsp_definitions({include_current_line = true}) end, 'jump to definition'},
    r = {function() telescope_builtin.resume() end, 'telescope resume'},
}, { prefix = "<leader>" })

local function get_visual_selection()
    -- Yank current visual selection into the 'v' register
    --
    -- Note that this makes no effort to preserve this register
    vim.cmd('noau normal! "vy"')

    return vim.fn.getreg('v')
end

wk.register({
	f = {
		name = '+telescope file_local',
		r = {function() telescope_builtin.live_grep({cwd = telescope_buf_cwd(), default_text = get_visual_selection()}) end, 'live_grep selection'},
	}
}, { prefix = "<leader>", mode = "v" })

-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pf',   telescope_builtin.git_files({cwd = WORKDIR, show_untracked = true}), {silent = true})
-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pglg', telescope_builtin.git_commits({cwd = WORKDIR}), {silent = true})
-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pglf', telescope_builtin.git_bcommits({cwd = WORKDIR}), {silent = true})
-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pgll', telescope_builtin.git_bcommits({cwd = WORKDIR}), {silent = true})
-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pgb',  telescope_builtin.git_branches({cwd = WORKDIR}), {silent = true})
-- vim.keymap.set({'n', 'v', 'i'}, '<leader>pgs',  telescope_builtin.git_status({cwd = WORKDIR}), {silent = true})
