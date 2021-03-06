"
" " Plugins
"

call plug#begin('~/.vim/plugged')

" let g:plug_url_format = "git://github.com/%s.git"
let g:plug_threads = 1

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'aklt/plantuml-syntax'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'axiom/vim-memcolo'
Plug 'brookhong/cscope.vim'
Plug 'dag/vim-fish'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'tag': '*' }
Plug 'garbas/vim-snipmate'
Plug 'gilgigilgil/anderson.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/calendar.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'peterhoeg/vim-qml'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/vim-slumlord'
Plug 'sickill/vim-monokai'
Plug 'sebdah/vim-delve'
Plug 'tclh123/vim-thrift'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-sleuth'
Plug 'twitvim/twitvim'
Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/Toggle'
Plug 'vimwiki/vimwiki'
Plug 'wimstefan/Lightning'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'zchee/deoplete-clang'
endif

call plug#end()

"
" " Plugin settings
"

" Use deoplete.
try
  let g:deoplete#enable_at_startup = 1
  set completeopt=menu
catch
  echo "Failed to enable deoplete."
endtry

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" vim-session
try
  let g:session_autoload = 'no'
  let g:session_autosave = 'yes'
catch
  echo "Failed to set vim-session configuration, vim-session might not be installed."
endtry

" ctrlp.vim
try
  let g:ctrlp_match_window = 'bottom,order:ttb'
  let g:ctrlp_switch_buffer = 0
  let g:ctrlp_working_path_mode = 0
  let g:ctrlp_custom_ignore = '\vbuild/|vendor/|dist/|venv/|\.(o|swp|pyc|egg)$'
  let g:ctrlp_map = '' " Use FZF
catch
endtry

" cpp enhanced highlight
try
  let g:cpp_class_scope_highlight = 1
  "let g:cpp_experimental_template_highlight = 1
catch
endtry

" JSON
try
  let g:vim_json_syntax_conceal = 0
catch
endtry

" FZF
try
  nnoremap <c-p> :FZF!<cr>
catch
endtry

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" LSP
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Neomake
try
  let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
  let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
  let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

  " neomake configuration for C++
  let g:neomake_cpp_enable_markers=['clang', 'cpplint']
  let g:neomake_cpp_lint_maker = { }
  let g:neomake_cpp_clang_args = ["-std=c++17", "-Wextra", "-Wall", "-fsanitize=undefined", "-g", "-I", "."]

  " neomake configuration for Go.
  let g:neomake_go_enabled_makers = [ 'go', 'golangci_lint', 'endsentence' ]
  let g:neomake_go_endsentence_maker = {
    \ 'args': [
    \   '.',
    \ ],
    \ 'append_file': 0,
    \ 'cwd': '%:p:h',
    \ }

  if !empty($NEOMAKE_PHPCS_STANDARD)
    let g:neomake_php_phpcs_args_standard = $NEOMAKE_PHPCS_STANDARD
  endif

  au FileType sh autocmd BufWritePost * Neomake
  au FileType go autocmd BufWritePost * Neomake
  au FileType php autocmd BufWritePost * Neomake
  au FileType h,hpp,cpp autocmd BufWritePost * Neomake
catch
endtry

" Go
try
  let g:go_fmt_command = "gofumports"

  let g:go_addtags_transform = "snakecase"

  let g:go_echo_command_info = 1

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  let g:go_auto_type_info = 0

  let go_doc_popup_window = 1 " Vim 8.1.1513
catch
endtry

" Calendar
try
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  let g:calendar_first_day = "monday"
  let g:calendar_date_endian = "big"
  let g:calendar_week_number = 1
  let g:calendar_view = "week"
catch
endtry

" cscope
try
  let g:cscope_silent = 1
catch
endtry

" editorconfig
try
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
catch
endtry

"
" " Theme
"

try
  " Switch bright/dark theme
  function! ToggleColorScheme()
    try
      if (g:colors_name == "lightning")
        colorscheme nord
      else
        colorscheme lightning
      endif
    catch
        colorscheme nord
    endtry
  endfunc

  "Set F5 to toggle
  nmap <silent> <F5> :call ToggleColorScheme()<CR>
catch
endtry

" Airline

try
  " Remove <> arrows in Airline
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
catch
endtry

" Vim wiki
try
  let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
catch
endtry

"
" " VIM
"

set nocompatible
syntax on

" History
set history=1000

" Indent
set autoindent
set smartindent
set softtabstop=8
set shiftwidth=8
set tabstop=8
set shiftround
set noexpandtab
set nowrap
set preserveindent

" VIM UI
filetype on
filetype plugin on
set ch=2
set wildmenu
set number " Line numbers
set report=0 " Do not show changes
set showmatch
set ruler
set incsearch
set smartcase
set backspace=2
set whichwrap+=<,>,[,],h,l
set shortmess=atI
set showmode
set showcmd
set laststatus=2 " Always show status
set visualbell
set mat=5       " duration to show matching brace (1/10 sec)
set showtabline=2 " Always show tab bar
set backupdir=~/.vim/backup " Backupfiles
set directory=~/.vim/tmp " Swapfiles
set hidden " Fix buffers requiring a save.

" set updatetime=200

" autocomplete
set omnifunc=syntaxcomplete#Complete

if v:version >= 703
  set undofile
  set undodir=~/.vim/undofiles

  " paint the max line
  "highlight ColorColumn ctermbg=131
  "call matchadd('ColorColumn', '\%79v', 100)
endif

" General
set encoding=utf-8
set textwidth=78

let mapleader =  ","

" Folds, this is damn nice
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

set list listchars=tab:»·,trail:·

" Turn on and off search highlighting
" switch higlight no matter the previous state
nmap <F1> :set hls! <cr>
" hit '/' highlights then enter search mode
nnoremap / :set hlsearch<cr>/

" Set tagbar toggle
nmap <F6> :TagbarToggle<CR>

" Remap ESC to jj
inoremap jj <ESC>

" Reload vimrc
map <leader>vr :so $MYVIMRC<CR>

" Twitter
map <leader>tw :FriendsTwitter<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" LanguageServer
au FileType c,cpp nnoremap <leader>gd :LspDefinition<CR>
au FileType c,cpp nnoremap <leader>rn :LspRename<CR>

" sb: Shorthand for splitting the buffer vertically.
nnoremap <leader>sb :vert sb<space>

" fa: Find files that has this word.
nnoremap <leader>fa :Ack! '<cword>'<CR>
" ä: Open Ack.
nnoremap <leader>ö :Ack!<space>

" buffers
nnoremap <leader>gn :bn<CR>
nnoremap <leader>gp :bp<CR>
nnoremap <leader>gd :bd<CR>

" left/right to step through buffers
nmap <left> :bp<cr>
nmap <right> :bn<cr>

nmap <leader>b :Buffers<cr>
nmap <leader>c :bd<cr>

" down/up to step through quickfix list
nmap <down> :cn<cr>zz
nmap <up> :cp<cr>zz

" Sessions
nmap <leader>s :SaveSession<cr>
nmap <leader>l :OpenSession<cr>

" ,d -> git diff
nnoremap <leader>d :Gdiff<CR>
nnoremap <leader>b :Gblame<CR>

" br: Toogle delve breakpoint
au FileType go nnoremap <leader>c :GoCoverageToggle<CR>
au FileType go nnoremap <leader>br :DlvToggleBreakpoint<CR>
au FileType go nnoremap <leader>bt :DlvTest<CR>
au FileType go nnoremap <leader>t :GoTest<CR>
au FileType go nnoremap <leader>gd :GoDoc<CR>
au FileType go nnoremap <leader>ga :GoAlternate<CR>
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')


autocmd BufNewFile,BufRead *.vue   set syntax=html
