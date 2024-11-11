local function map(mode, l, r, opts)
	opts = opts or {}
	opts.buffer = bufnr
	opts.silent = (opts.silent == nil) or opts.silent
	vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>se', '<cmd>setlocal spell! spelllang=en_us<CR>', {expr=true})
map('n', '<leader>sr', '<cmd>setlocal spell! spelllang=ru_ru<CR>', {expr=true})
map('n', '<leader>su', '<cmd>setlocal spell! spelllang=uk_ua<CR>', {expr=true})

map('n', 'H', '^')
map('n', 'L', '$')

map('t', '<A-h>', '<C-\\><C-N><C-w>h')
map('t', '<A-j>', '<C-\\><C-N><C-w>j')
map('t', '<A-k>', '<C-\\><C-N><C-w>k')
map('t', '<A-l>', '<C-\\><C-N><C-w>l')
map('i', '<A-h>', '<C-\\><C-N><C-w>h')
map('i', '<A-j>', '<C-\\><C-N><C-w>j')
map('i', '<A-k>', '<C-\\><C-N><C-w>k')
map('i', '<A-l>', '<C-\\><C-N><C-w>l')
-- ' \ ''
-- reseting broken tree-sitter highlight :)
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')
map('n', '<A-n>', ':tabn<CR>')
map('n', '<A-p>', ':tabp<CR>')

map('n', '<leader>z', 'za')

map('n', '<C-s>', '<cmd>update<CR>', {expr=true})

map('v', '.'        , ':normal .<CR>')
map('v', '<leader>h', '<gv')
map('v', '<leader>l', '>gv')
map('v', 'P'        , '"0p')

map('t', '<Esc>', '<C-\\><C-n>')
map('n', 'T'    , ':terminal<CR>', {expr=true})

vim.api.nvim_create_user_command('Vrc', 'tabedit ~/.config/nvim/init.vim', { bang = true })
vim.api.nvim_create_user_command('Vrc', 'tabedit ~/.zshrc', { bang = true })

vim.api.nvim_create_user_command('Gcs', ':vertical Git commit --signoff <args>',
								 { bang = true, nargs = '?' })
vim.api.nvim_create_user_command('G', ':tab Git', { bang = true })
