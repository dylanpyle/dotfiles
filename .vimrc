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

" ,f as an alias for NERDTreeFind
nmap <Leader>f :NERDTreeFind<CR>

" ,b to git blame
nmap <Leader>b :tabe\|read !git blame --date=short #<CR>

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

" Allow ctrl+@ on CtrlP buffer list to delete buffers
let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-l> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

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

" Set text limit to 80 characters
set tw=80

" Enable automatic text wrapping
set fo+=t

" Show tabs
set list
set listchars=tab:▸·

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

" Allow JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

" Set current color scheme
set background=dark
colorscheme xcodedark

" Transparent-ish background
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi EndOfBuffer ctermbg=NONE

" Update tab bar & status bar colors
" hi TabLineFill ctermfg=233 ctermbg=233
" hi TabLine ctermfg=Black ctermbg=Black
" hi TabLineSel ctermfg=Blue ctermbg=Black
hi StatusLine ctermbg=White ctermfg=234

" Highlight any trailing whitespace
highlight ExtraWhitespace ctermbg=61
match ExtraWhitespace /\s\+$/

" Show row/column position
set ruler

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


" ~~~ Coc ~~~
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> = :CocDiagnostics<CR>
autocmd FileType typescript let b:coc_root_patterns = ['.git', '.env']
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

" Gross aliases for more memorable setup/teardown due to
" https://github.com/fannheyward/coc-deno/issues/7
command DenoSetup CocInstall coc-deno
command DenoTeardown CocUninstall coc-deno

" ~~~ Misc ~~~

" Mouse
set mouse=n

" Fix strange backspace behavior
set backspace=2

" Improve scroll performance (uhh...?)
set ttyfast
