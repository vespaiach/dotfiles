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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Better display for messages
set cmdheight=2

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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim-go
Plug 'fatih/vim-go'

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
"" Vim-go Plugin Setups
"*****************************************************************************
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
let g:go_list_type = 'quickfix'
let g:go_addtags_transform = 'camelcase'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-d> :GoDeclsDir<cr>
imap <C-d> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>buildGoFiles()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" buildGoFiles is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:buildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
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
"" Floating Window Setups
"*****************************************************************************
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

" Open terminal
nnoremap <Leader>at :call FloatTerm()<CR>
" Open node REPL
nnoremap <Leader>an :call FloatTerm('"node"')<CR>
" Open tig, yes TIG, A FLOATING TIGGGG!!!!!!
nnoremap <Leader>ag :call FloatTerm('"tig"')<CR>
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
