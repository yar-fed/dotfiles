nnoremap <Space> <Nop>
let mapleader = " "

" settings
	set tabstop=4               " number of columns occupied by a tab character
	set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
	set shiftwidth=4            " width for autoindents
	set undodir=~/.config/nvim/undodir

" important (custom set)
	set iskeyword+=-			" remove '-' for w jumps
	set mouse=a                 " Automatically enable mouse usage
	set mousehide               " Hide the mouse cursor while typing
	set autoindent              " indent a new line the same amount as the line just typed
	set scrolloff=2
	set wildmenu
	set wildmode=longest:full,full
	set cc=80,100
	set foldlevelstart=99
	filetype plugin indent on   " allows auto-indenting depending on file type
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	set number
	set cursorline
	set clipboard=unnamedplus
	set title
	set sb                      " split below
	set spr                     " split right
	set showmatch               " show matching brackets.
	set ignorecase              " case insensitive matching
	set cmdheight=0



call plug#begin()
	Plug 'ap/vim-css-color'
	Plug 'tanvirtin/monokai.nvim'
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'deris/vim-shot-f'
	Plug 'yggdroot/indentline'
	Plug 'godlygeek/tabular'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'bronson/vim-visual-star-search'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/playground'
	Plug 'simeji/winresizer'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
	Plug 'numToStr/Comment.nvim'
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'folke/which-key.nvim'

	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'

	Plug 'Glench/Vim-Jinja2-Syntax'
	Plug 'midchildan/ft-confluence.vim'
	Plug 'harrisoncramer/gitlab.nvim', { 'do': ':lua require(gitlab.server).build(true)' }
	Plug 'MunifTanjim/nui.nvim'
	Plug 'sindrets/diffview.nvim'
call plug#end()

" au! BufNewFile,BufRead *.h set filetype=c
" au! FileType c,cpp setlocal noet softtabstop=8 shiftwidth=8 tabstop=8 foldnestmax=1 foldmethod=expr foldexpr=nvim_treesitter#foldexpr() fixeol
" au! FileType c,cpp setlocal noet softtabstop=8 shiftwidth=8 tabstop=8 foldnestmax=1 foldmethod=manual foldtext=v:lua.vim.treesitter.foldtext() fixeol
au! FileType c setlocal noet shiftwidth=8 softtabstop=8 tabstop=8 foldnestmax=1 foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldtext= fixeol
au! FileType cpp setlocal et shiftwidth=4 softtabstop=8 tabstop=8 foldnestmax=1 foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldtext= fixeol
au! FileType python setlocal et softtabstop=4 shiftwidth=4 tabstop=4 foldnestmax=1 foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldtext= fixeol
au! FileType xml,yang,json setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2 indentexpr="" conceallevel=0


" spelling
	map <silent> <leader>se :setlocal spell! spelllang=en_us<CR>
	map <silent> <leader>sr :setlocal spell! spelllang=ru_ru<CR>
	map <silent> <leader>su :setlocal spell! spelllang=uk_ua<CR>


" shortcuts for configs
	command! Vrc :tabedit ~/.config/nvim/init.vim
	command! Zrc :tabedit ~/.zshrc

" Session save command
	command! -bar SaveSession :mks! ./.vim_s
	command! -bar SaveAll :wa
	command! CloseSession :qa
	command! Sexit SaveAll|SaveSession|CloseSession

" Moves inside window
	noremap <silent> H ^
	noremap <silent> L $

" Window change
	tnoremap <silent> <A-h> <C-\><C-N><C-w>h
	tnoremap <silent> <A-j> <C-\><C-N><C-w>j
	tnoremap <silent> <A-k> <C-\><C-N><C-w>k
	tnoremap <silent> <A-l> <C-\><C-N><C-w>l
	inoremap <silent> <A-h> <C-\><C-N><C-w>h
	inoremap <silent> <A-j> <C-\><C-N><C-w>j
	inoremap <silent> <A-k> <C-\><C-N><C-w>k
	inoremap <silent> <A-l> <C-\><C-N><C-w>l
	nnoremap <silent> <A-h> <C-w>h
	nnoremap <silent> <A-j> <C-w>j
	nnoremap <silent> <A-k> <C-w>k
	nnoremap <silent> <A-l> <C-w>l
	nnoremap <silent> <A-n> :tabn<CR>
	nnoremap <silent> <A-p> :tabp<CR>

" Folding toggle
	nnoremap <silent> <leader>z za

" Saving shortcuts
	nnoremap <silent> <C-s> <cmd>update<CR>

" VIsual mode related
	vnoremap <silent> . :normal .<CR>
	vnoremap <silent> <leader>h <gv
	vnoremap <silent> <leader>l >gv
	vnoremap <silent> P "0p

" Terminal
	tnoremap <Esc> <C-\><C-n>
	nnoremap T :terminal<CR>

lua require('pluginit')
lua require('workspace')

" lsp
	nnoremap <silent> <leader>k :lua vim.lsp.buf.hover()<CR>
	" nnoremap <silent> <leader>d :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <leader>lr :lua vim.lsp.buf.rename()<CR>
	" nnoremap <silent> <leader>lj :lua vim.lsp.buf.references()<CR>
	nnoremap <silent> <leader>lq :lua vim.diagnostic.set_qflist()<CR>
	nnoremap <silent> <leader>ln :lua vim.diagnostic.goto_next()<CR>
	nnoremap <silent> <leader>lp :lua vim.diagnostic.goto_prev()<CR>
	nnoremap <silent> <leader>ll <cmd>tab split \| lua vim.lsp.buf.definition()<CR>

" Gitsigns
	nnoremap <silent> ]h <Cmd>silent! Gitsigns next_hunk<CR>
	nnoremap <silent> [h <Cmd>silent! Gitsigns prev_hunk<CR>

" Indentline
	let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" telescope
	nnoremap <silent> <leader>ge <cmd>Telescope file_browser<cr>
	nnoremap <silent> <leader>fe <cmd>Telescope file_browser cwd=%:h<cr>
	nnoremap <silent> <leader>gf <cmd>Telescope find_files<cr>
	nnoremap <silent> <leader>ff <cmd>Telescope find_files cwd=%:h<cr>
	nnoremap <silent> <leader>gr <cmd>Telescope live_grep<cr>
	nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <silent> <leader>fj <cmd>Telescope current_buffer_fuzzy_find<cr>
	cmap <silent> <C-F> <Plug>(TelescopeFuzzyCommandSearch)
	nmap <silent> q: <Plug>(TelescopeFuzzyCommandSearch)
	nmap <silent> q/ <Nop>

nnoremap <silent> 5j %
vnoremap <silent> 5j %

" qlist
	nnoremap <silent> <leader>cn <cmd>cnext<cr>
	nnoremap <silent> <leader>cp <cmd>cprevious<cr>
	nnoremap <silent> <leader>cqn <cmd>cnewer<cr>
	nnoremap <silent> <leader>cqp <cmd>colder<cr>

" Fugitive
	command! -nargs=? Gcs :vertical Git commit --signoff <args>
	command! G :tab Git

" vim-vsnip
	imap <silent> <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
	smap <silent> <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
	imap <silent> <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
	smap <silent> <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

function! Searchcount() abort
	try
		if v:hlsearch ==# 0
			return ''
		endif
		let result = searchcount(#{recompute: 1, maxcount: -1})
		if empty(result) || result.total ==# 0
			return ''
		endif
		if result.incomplete ==# 1     " timed out
			return '[?/??]'
		elseif result.incomplete ==# 2 " max count exceeded
			return printf(result.current > result.maxcount ? '[>%d/>%d]' : '[%d/>%d]',
			\		      result.current, result.total)
		endif
		return printf('[%d/%d]', result.current, result.total)
	catch
		return ''
	endtry
endfunction

function! Visualcount() abort
	let result = get(wordcount(), 'visual_chars', 0)
	return result ? printf('[selected %d]', result) : ''
endfunction

" Light line
	set noshowmode
	let g:lightline = {
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'filename', 'readonly', 'gitbranch', 'modified' ]],
		\   'right': [ [ 'lineinfo' ],
		\              [ 'charvaluehex' ],
		\              [ 'visualcount', 'searchcount', 'filetype' ] ]
		\ },
		\ 'enable': {
		\   'statusline': 1,
		\   'tabline': 0
		\ },
		\ 'component': {
		\   'lineinfo': '%3l:%-2v'
		\ },
		\ 'component_function': {
		\   'visualcount': 'Visualcount',
		\   'searchcount': 'Searchcount',
		\   'gitbranch': 'FugitiveHead'
		\ },
		\ 'separator': { 'left': "\uE0B0", 'right': "\uE0B2" },
		\ 'subseparator': { 'left': "", 'right': "" },
		\ }

" Stop setting of conceal
let g:indentLine_setConceal=0
set foldtext=

" hi CursorLine gui=underline guisp=#4d5154
