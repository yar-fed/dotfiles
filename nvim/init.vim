nnoremap <Space> <Nop>
let mapleader = " "

" settings
	set nocompatible            " disable compatibility to old-time vi
	set title
	set sb                      " split below
	set spr                     " split right
	set showmatch               " show matching brackets.
	set ignorecase              " case insensitive matching
	set tabstop=4               " number of columns occupied by a tab character
	set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
	set shiftwidth=4            " width for autoindents
	set encoding=utf-8
	set conceallevel=0
	set undodir=~/.config/nvim/undodir
	set mouse=a                 " Automatically enable mouse usage
	set mousehide               " Hide the mouse cursor while typing
	set autoindent              " indent a new line the same amount as the line just typed
	set number                  " add line numbers
	set wildmenu
	set wildmode=longest:full,full
	set cc=100
	filetype plugin indent on   " allows auto-indenting depending on file type
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	set number
	set updatetime=1200
	set cursorline
	set clipboard=unnamed,unnamedplus
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	highlight EndOfBuffer guifg=bg


"	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"	Plug 'deoplete-plugins/deoplete-lsp'
call plug#begin()
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'ap/vim-css-color'
	Plug 'tanvirtin/monokai.nvim'
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'deris/vim-shot-f'
	Plug 'yggdroot/indentline'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'godlygeek/tabular'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'bronson/vim-visual-star-search'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'simeji/winresizer'
	Plug 'szw/vim-maximizer'
	Plug 'nathanalderson/yang.vim'
	Plug 'sunjon/Shade.nvim'
	Plug 'ms-jpq/coq_nvim'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" .c files
	au BufNewFile,BufRead *.c set filetype=c
	au BufNewFile,BufRead *.h set filetype=c
	au FileType c,cpp setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4 foldnestmax=1 foldmethod=syntax
	au FileType xml,yang setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2


" spelling
	map <leader>se :setlocal spell! spelllang=en_us<CR>
	map <leader>sr :setlocal spell! spelllang=ru_ru<CR>
	map <leader>su :setlocal spell! spelllang=uk_ua<CR>


" Set US Layout on leaving insert mode
	function! SetUsLayout()
		silent !gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval  "imports.ui.status.keyboard.getInputSourceManager().inputSources[0].activate()" > /dev/null
	endfunction
	autocmd InsertLeave * call SetUsLayout()

" shortcuts for configs
	command! Reload source ~/.config/nvim/init.vim
	command! Vrc :tabedit ~/.config/nvim/init.vim
	command! Brc :tabedit ~/.bashrc

" Session save command
	command! -bar DisableShade :lua require'shade'.disable()
	command! -bar SaveSession :mks! ./.vim_s
	command! -bar SaveAll :wa
	command! CloseSession :qa
	command! Sexit DisableShade|SaveAll|SaveSession|CloseSession

" Moves inside window
	noremap H ^
	noremap L $

" quicklist
	noremap J :cnext<CR>
	noremap K :cprevious<CR>

" Window change
	tnoremap <A-h> <C-\><C-N><C-w>h
	tnoremap <A-j> <C-\><C-N><C-w>j
	tnoremap <A-k> <C-\><C-N><C-w>k
	tnoremap <A-l> <C-\><C-N><C-w>l
	inoremap <A-h> <C-\><C-N><C-w>h
	inoremap <A-j> <C-\><C-N><C-w>j
	inoremap <A-k> <C-\><C-N><C-w>k
	inoremap <A-l> <C-\><C-N><C-w>l
	nnoremap <A-h> <C-w>h
	nnoremap <A-j> <C-w>j
	nnoremap <A-k> <C-w>k
	nnoremap <A-l> <C-w>l
	nnoremap <A-n> :tabn<CR>
	nnoremap <A-p> :tabp<CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo -S tee % >/dev/null' <bar> edit!

" Folding toggle
	nnoremap <leader>z za
	nnoremap z<Space> za
	nnoremap <leader><leader> za

" Saving shortcuts
	nnoremap <C-s> :update<CR>
	nnoremap <leader>s :update<CR>

nnoremap <leader>qq ZZ
nnoremap <leader>qf ZQ

nnoremap S :%s//g<Left><Left>

" VIsual mode related
	nnoremap <leader>v V
	vnoremap . :normal .<CR>
	vnoremap <leader>h <gv
	vnoremap <leader>l >gv

" Terminal
	tnoremap <Esc> <C-\><C-n>
	nnoremap T :terminal<CR>

" Disassabling
	command! Disassable :e!<CR> :%!xxd -c 32 -g 8 %<CR> :set filetype=xxd<CR>

colorscheme monokai
syntax on                   " syntax highlighting
set termguicolors

" Custom highlights
"	hi! Number gui=italic
"	hi! Comment gui=italic
"	hi! Type gui=italic
"	hi! TSParameter gui=italic guifg=#fd971f
"	hi! link TSType Type
"	hi! link TSField TSParameter
"	hi! link TSProperty TSField

" lsp
	luafile ~/.config/nvim/lsp.lua
	nnoremap <silent> <leader>k :lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <leader>d :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <leader>lk :lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <leader>ld :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <leader>lr :lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <leader>lj :lua vim.lsp.buf.references()<CR>
	nnoremap <silent> <leader>lq :lua vim.lsp.diagnostic.set_qflist()<CR>
	nnoremap <silent> <C-k> :lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <leader>l <cmd>tab split \| lua vim.lsp.buf.definition()<CR>

" Deoplete
	let g:deoplete#enable_at_startup = 1
	autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

" Indentline
	let g:indentLine_char_list = ['|', '¦', '┆', '┊']

luafile ~/.config/nvim/pluginit.lua

" telescope
	nnoremap <leader>fv <cmd>Telescope file_browser<cr>
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fj <cmd>Telescope current_buffer_fuzzy_find<cr>
	cmap <C-F> <Plug>(TelescopeFuzzyCommandSearch)
	nmap q: <Plug>(TelescopeFuzzyCommandSearch)
	nmap q/ <Nop>

" Fugitive
	command! -nargs=? Gcs :vertical Git commit --signoff <args>
	command! G :tab Git

" Light line
	set noshowmode
	let g:lightline = {
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'filename', 'readonly', 'gitbranch', 'modified' ] ],
		\   'right': [ [ 'lineinfo' ],
		\              [ 'percent' ],
		\              [ 'filetype' ] ]
		\ },
		\ 'component_function': {
		\   'gitbranch': 'FugitiveHead'
		\ },
		\ 'separator': { 'left': "\uE0B0", 'right': "\uE0B2" },
		\ 'subseparator': { 'left': "", 'right': "" },
		\ }

" hi CursorLine gui=underline guisp=#4d5154
