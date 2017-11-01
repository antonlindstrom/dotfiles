"
" " Plugins
"

call plug#begin('~/.vim/plugged')

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'airblade/vim-gitgutter'
Plug 'axiom/vim-memcolo'
Plug 'brookhong/cscope.vim'
Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'garbas/vim-snipmate'
Plug 'gilgigilgil/anderson.vim'
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'honza/vim-snippets'
Plug 'itchyny/calendar.vim'
Plug 'junegunn/vim-easy-align'
Plug 'keith/swift.vim'
Plug 'kien/ctrlp.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'peterhoeg/vim-qml'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'sickill/vim-monokai'
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
Plug 'vimwiki/vimwiki'
Plug 'wimstefan/Lightning'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

call plug#end()

"
" " Plugin settings
"

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
  let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|\.(o|swp|pyc|egg)$'
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

" Go
try
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
catch
endtry

" Syntastic CPP
try
  " CPP linter
  let g:syntastic_cpp_cpplint_exec = 'cpplint'
  let g:syntastic_cpp_checkers = ['gcc', 'cpplint']
  let g:syntastic_cpp_compiler_options = ' -std=c++11'
catch
endtry

" Calendar
try
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
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
        colorscheme monokai
      else
        colorscheme lightning
      endif
    catch
        colorscheme monokai
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
