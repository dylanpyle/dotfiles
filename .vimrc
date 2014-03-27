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

" Clear current search when pressing Enter
nnoremap <CR> :noh<CR><CR>

" Additional settings for wildcard ignoring (also used in CtrlP)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/bower_components/*


" ~~~ Display options ~~~

" Show line numbers
set number

" Show cursor line
set cursorline

" Show 80 character marker
set colorcolumn=80

" ... in black
hi ColorColumn ctermbg=black

" Syntax highlighting / ft detection
syntax on
filetype plugin indent on

" Set current color scheme
set background=dark
colorscheme solarized


" ~~~ Misc ~~~

" Enable per-directory .vimrc files
set exrc

" Disable unsafe commands in local .vimrc files
set secure
