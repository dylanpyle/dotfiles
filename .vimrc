call plug#begin()
Plug 'lunacookies/vim-colors-xcode'
Plug 'preservim/nerdtree', { 'tag': '7.1.1' }
Plug 'kien/ctrlp.vim', { 'tag': '1.79' }
Plug 'neovim/nvim-lspconfig', { 'tag': 'v0.1.7' }
Plug 'github/copilot.vim', { 'tag': 'v1.17.0' }
call plug#end()

" LSP integration. Note: Lua time!
lua << EOF
  vim.g.markdown_fenced_languages = {
    "ts=typescript"
  }

  local nvim_lsp = require('lspconfig')

  nvim_lsp.denols.setup {
    on_attach = on_attach,
    root_dir = function (fname)
      -- In a project with both deno and node files in parent directories, don't attach denols
      -- This is mostly to play nice with a specific monorepo which has a deno.json in the root,
      -- so may want to reevaluate this in the future
      local deno_path = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")(fname)
      local node_path = nvim_lsp.util.root_pattern("package.json")(fname)
      if (deno_path and (not node_path)) then
        return deno_path
      else
        return nil
      end
    end
  }

  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    single_file_support = false
  }

  nvim_lsp.tailwindcss.setup {
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("tailwind.config.ts")
  }

  vim.keymap.set('n', '[e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '=', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
  })
EOF


" # Key mappings

let mapleader=','

" Allow ; in place of :
noremap ; :

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


" # Indentation options

" Display tabs as 2 characters wide
set tabstop=2

" Create spaces instead of tabs when pressing <Tab>
set expandtab

" Use 2 spaces when inserting tab at the front of a line
set smarttab

" Move indents by 2 when << or >>
set shiftwidth=2

" ... even for Markdown files
let g:markdown_recommended_style = 0

" ... but round to the nearest 2
set shiftround

" Set text limit to 80 characters
set tw=80

" Enable automatic text wrapping
set fo+=t

" Show tabs
set list
set listchars=tab:▸·


" # Searching

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


" # Display options

" Show line numbers
set number

" Show 80 character marker
set cc=80

" Syntax highlighting / ft detection
syntax on
filetype plugin indent on

" Set current color scheme
set background=dark
colorscheme xcodedark

" Transparent-ish background
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi EndOfBuffer ctermbg=NONE

" Update tab bar & status bar colors
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

" Remove scratch buffer when accepting <c-x><c-o> autocompletion
set completeopt-=preview


" # Misc

" Mouse
set mouse=n

" Fix strange backspace behavior
set backspace=2

" Improve scroll performance (uhh...?)
set ttyfast
