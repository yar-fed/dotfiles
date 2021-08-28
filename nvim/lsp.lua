local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
local coq = require "coq"
local lspconfig = require'lspconfig'

lspconfig.ccls.setup {
	coq.lsp_ensure_capabilities({init_options = { cache = { directory = ".ccls-cache"; }; }})
}
lspconfig.pylsp.setup{coq.lsp_ensure_capabilities()}

local opts = { noremap=true, silent=true }
vim.api.nvim_exec([[
	hi LspReferenceRead  cterm=bold ctermbg=red guifg=DarkGreen guibg=LightYellow
	hi LspReferenceText  cterm=bold ctermbg=red guifg=DarkGreen guibg=LightYellow
	hi LspReferenceWrite cterm=bold ctermbg=red guifg=DarkGreen guibg=LightYellow
	augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer>  lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	augroup END
]], false)

vim.g.coq_settings = { auto_start = true, ["limits.index_cutoff"] = 600000 }
