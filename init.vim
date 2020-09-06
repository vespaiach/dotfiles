"*****************************************************************************
"" Basic Setup
"*****************************************************************************
filetype plugin indent on

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Alias unnamed register to the * register
set clipboard=unnamed

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"" Map leader to space
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Completion Options
set completeopt-=preview

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

"" Persistent undo
if has('persistent_undo')
  set undofile
  " Run mkdir ~/.vim/undo if undo folder is not exists
  set undodir=~/.vim/undo
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set ruler
set number

let no_buffers_menu = 1

set mouse=a
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has('mouse_sgr')
  set ttymouse=sgr
endif

if &term =~ '256color'
  set t_ut=
endif

"" Highlight line
" Disable to speed up highlighting
" set cursorline
hi cursorline cterm=none term=none
highlight CursorLine ctermbg=235

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=0

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold=
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists('*fugitive#statusline')
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Plugins
"*****************************************************************************
call plug#begin()

"" Themes
Plug 'sonph/onehalf', {'rtp': 'vim/'}

"" Visual tab {bottom}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Tree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

"" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Smart comments
Plug 'tpope/vim-commentary'

"" Git
Plug 'tpope/vim-fugitive'

"" Shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

"" Simplifies the transition between multiline and single-line code (gS, gJ)
Plug 'AndrewRadev/splitjoin.vim'

"" Type vv inside pairs objects such as () to select content
Plug 'gorkunov/smartpairs.vim'

"" Type * to search the word under the cursor or selected text
Plug 'thinca/vim-visualstar'

"" Helpers for UNIX (:Delete, :Move, :Chmod,...)
Plug 'tpope/vim-eunuch'

"" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

"" EditorConfig plugin for Vim
Plug 'editorconfig/editorconfig-vim'

"" Interactive command execution in Vim.
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"" Improved integration between Vim and its environment
Plug 'Shougo/vimshell.vim'

"" Asks to create directories in Vim when needed
Plug 'jordwalke/VimAutoMakeDirectory'

" Use Coc Vim release branch 
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Helpers
Plug 'phongnh/vim-search-helpers'

call plug#end()

"*****************************************************************************
"" Plugin Setups
"*****************************************************************************
" Themes
colorscheme onehalfdark
set background=dark

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onehalfdark'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='!'

"" Vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = '$ '

" NERDTree
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30

"*****************************************************************************
"" Coc Vim Plugin Setups
"*****************************************************************************
" Install coc extensions
let g:coc_global_extensions = [
\ 'coc-prettier',
\ 'coc-eslint',
\ 'coc-json',
\ 'coc-css',
\ 'coc-tsserver'
\]

" Custom icon for coc.nvim statusline
let g:coc_status_error_sign="ce "
let g:coc_status_warning_sign="ew "

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <Leader>F :CocCommand prettier.formatFile<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-a> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-a> <Plug>(coc-range-select)
xmap <silent> <C-a> <Plug>(coc-range-select)

" Searching
nnoremap <Leader>s :CocSearch <C-r>=expand("<cword>")<CR><CR>
xnoremap <Leader>s <Esc>:CocSearch <C-r>=escape(GetSelectedText(), '"%#*$(){} ')<CR><CR>

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

set autoread
set autowrite

"*****************************************************************************
"" Key Maps
"*****************************************************************************
noremap <Leader>n :NERDTreeTabsToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <silent> <ESC> :noh<CR>
nnoremap <ESC>^[ <ESC>^[

" Replace
nnoremap <Leader>S :%s/<C-r>=GetWordForSubstitute()<CR>/gcI<Left><Left><Left><Left>
xnoremap <Leader>S <Esc>:%s/<C-r>=GetSelectedTextForSubstitute()<CR>//gcI<Left><Left><Left><Left>

" Close the quickfix window with <leader>a
nnoremap <leader>x :cclose<CR>

" Remap scrolling
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

" don't use recording
map q <Nop>
