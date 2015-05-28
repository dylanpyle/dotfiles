execute pathogen#infect()


" ~~~ Key mappings ~~~

let mapleader=','

" Allow ; in place of :
noremap ; :

" Disable arrow keys to cure muscle memory
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Use Tab and Shift-Tab to switch buffers
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> <Tab> :bn<CR>

" <Leader>y and <Leader>p for copy/paste to system clipboard
vmap <Leader>y :!pbcopy && pbpaste<CR>
nnoremap <Leader>p :read !pbpaste<CR><Esc>
vmap <Leader>q :!coffee -bcsp --no-header<CR>

" Back to single-prefix EasyMotion movements
map <Leader> <Plug>(easymotion-prefix)

" Use <Space> to toggle NERDTree
noremap <Space> :NERDTreeToggle<CR>

" In visual mode, use space for EasyAlign
vmap <Space> :EasyAlign\ <CR>

" Remap CtrlP key to backslash
let g:ctrlp_map = '<Bslash>'

" Open CtrlP in the last mode (switch with c-f and c-b) we were using
let g:ctrlp_cmd = 'CtrlPLastMode'

" Add fuzzy line extension
let g:ctrlp_extensions = ['line']


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

" Show cursor line
set cursorline

" Show 80 character marker
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Syntax highlighting / ft detection
syntax on
filetype plugin indent on

" Set current color scheme
set background=dark
colorscheme hybrid

" Define whitespace colors
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen

" Show trailing whitespace, except when typing
match ExtraWhitespace /\s\+\%#\@<!$/

" Show row/column positin
set ruler

" Only show cursorline in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Hide NERDTree clutter
let NERDTreeMinimalUI=1


" ~~~ Misc ~~~

" Enable per-directory .vimrc files
set exrc

" Disable unsafe commands in local .vimrc files
set secure

" Allow mouse
set mouse=a

" Fix strange backspace behavior
set backspace=2
