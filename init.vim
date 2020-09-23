"*****************************************************************************
"" Plugins
"*****************************************************************************
call plug#begin()

" https://github.com/sheerun/vimrc
Plug 'sheerun/vimrc'

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

" Use vim-polyglot
Plug 'sheerun/vim-polyglot'


" Linting and fixing
Plug 'dense-analysis/ale'
" Fix files with prettier, and then ESLint
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint']
\}
" Change signs of error and warning
let g:ale_sign_error = 'e'
let g:ale_sign_warning = 'w'


" Helpers
Plug 'phongnh/vim-search-helpers'

call plug#end()

"*****************************************************************************
"" Plugin Setups
"*****************************************************************************
" Themes
colorscheme onehalfdark
" Enable true color (24bits)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
" Leader key
let mapleader = "\<Space>"
nnoremap <C-p> :Files<CR>
noremap <Leader>f :ALEFix<CR>
noremap <Leader>g :ALEGoToDefinition<CR>
noremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <ESC> :noh<CR>
nnoremap <ESC>^[ <ESC>^[

" Remap scrolling
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
