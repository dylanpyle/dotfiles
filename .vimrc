execute pathogen#infect()


" ~~~ Key mappings ~~~

let mapleader=','

" Allow ; in place of :
noremap ; :

" Use shift-tab for c-x c-o autocomplete
inoremap <S-Tab> <C-x><C-o>

" <Leader>y and <Leader>p for copy/paste to system clipboard
vmap <Leader>y "*y<CR>
nnoremap <Leader>p "*p<CR><Esc>

" cp to copy file path to system clipboard
nmap cp :let @* = expand("%")<CR>

" Back to single-prefix EasyMotion movements
map <Leader> <Plug>(easymotion-prefix)

" Use <Space> to toggle NERDTree
noremap <Space> :NERDTreeToggle<CR>

" In visual mode, use space for sort
vmap <Space> :sort i<CR>

" Remap CtrlP key to backslash
let g:ctrlp_map = '<Bslash>'

" Use | for CtrlP Buffer Mode
noremap <Bar> :CtrlPBuffer<CR>

" Open CtrlP in file mode (switch with c-f and c-b)
let g:ctrlp_cmd = 'CtrlP'

" Add fuzzy line extension
let g:ctrlp_extensions = ['line']

" Allow :NF as an alias for NERDTreeFind
command NF NERDTreeFind

" Remap = to ALELint
nnoremap = :ALELint<CR>


" Allow <esc><esc> to escape terminal buffers
" (neovim-specific; disabled for right now since I use this file as my .vimrc
" too and don't use this feature often enough to bother figuring out how to keep
" it from throwing errors in vim)
"
" tnoremap <esc><esc> <C-\><C-n>


" ~~~ Indentation options ~~~

" Display tabs as 2 characters wide
set tabstop=2

" Create spaces instead of tabs when pressing <Tab>
set expandtab

" Use 2 spaces when inserting tab at the front of a line
set smarttab

" Move indents by 2 when << or >>
set shiftwidth=2

" ... but round to the nearest 2
set shiftround

" Use tabs for golang
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" Set text limit to 80 characters
set tw=80

" Enable automatic text wrapping
set fo+=t


" ~~~ Searching ~~~

" Default to case-insensitive search
set ignorecase

" ... except when search contains an uppercase
set smartcase

" Highlight all matches
set hlsearch

" Clear current search when pressing Enter
nnoremap <CR> :noh<CR><CR>

" Additional settings for wildcard ignoring (also used in CtrlP)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/bower_components/*
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" ~~~ Display options ~~~

" Show line numbers
set number

" Show 80 character marker
set cc=80

" Syntax highlighting / ft detection
syntax on
filetype plugin indent on

" Allow JSX highlighting in *.js
let g:jsx_ext_required = 1

" Allow JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

" Set current color scheme
set background=dark
colorscheme iceberg

" Update tab bar colors
hi TabLineFill ctermfg=233 ctermbg=233
hi TabLine ctermfg=Black ctermbg=Black
hi TabLineSel ctermfg=Blue ctermbg=Black

" Highlight any trailing whitespace
highlight ExtraWhitespace ctermbg=61
match ExtraWhitespace /\s\+$/

" Show row/column position
set ruler

" Only show cursorline in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Hide NERDTree clutter
let NERDTreeMinimalUI=1

" Don't quit NERDTree when we open a tab
let NERDTreeQuitOnOpen = 0

" Always show statusline
set laststatus=2

" Set up statusline
set statusline=\ \»\ %f  " Path to current file
set statusline+=%=       " Align right
set statusline+=%c\,%l   " Current position in file
set statusline+=\ \/\ %L " Slash
set statusline+=\ %r%w%h " Any flags (readonly etc)

" Remove splash screen
set shortmess+=I

" Set up Ale
let g:ale_completion_enabled = 1
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_keep_list_window_open = 1
let g:ale_completion_delay = 200
let g:ale_completion_max_suggestions = 10
highlight ALEError cterm=underline
let g:ale_linters = {
\    'typescript': ['tslint', 'tsserver'],
\}

" Disabled for now due to https://github.com/w0rp/ale/issues/1529
" let g:ale_lint_on_insert_leave = 1

" ~~~ Misc ~~~

" Mouse
set mouse=n

" Fix strange backspace behavior
set backspace=2

" MacVim only - hide scrollbars
set guioptions=

" MacVim - set GUI font
set guifont=Inconsolata\ Regular:h17
