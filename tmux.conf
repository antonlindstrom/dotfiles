""""""""""""""""""""""""""""""""""""""""""""""""
" Anton Lindstrom's .vimrc
"
" github.com/antonlindstrom/vim
""""""""""""""""""""""""""""""""""""""""""""""""

" Getting rid of vi bugs and turns syntax highlighting on
set nocompatible
syntax on

" History
set history=1000

" Indent
set autoindent
set smartindent
set softtabstop=2
set shiftwidth=2
set tabstop=2
set shiftround
set expandtab
set nowrap
set preserveindent
set pastetoggle=<F12> "Press <F12> when paste-alot

" VIM UI
filetype on
filetype plugin on
set ch=2
set wildmenu
"set t_Co=256 "256 colors
set number " Line numbers
set report=0 " Do not show changes
set showmatch
set ruler
set incsearch
set ignorecase " Ignore case on search
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

" Solarized https://github.com/altercation/vim-colors-solarized
set background=dark
colorscheme solarized

" Trailing whitespaces
set list listchars=tab:»·,trail:·

" Filetypes
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Set the keys to turn spell checking on/off
map <F7> <Esc>:setlocal spell spelllang=sv<CR>
map <F8> <Esc>:setlocal spell spelllang=en_us<CR>
map <F9> <Esc>:setlocal nospell<CR>
