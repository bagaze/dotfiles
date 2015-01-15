set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Personnal plugins
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'

" Color Scheme
Plugin 'sickill/vim-monokai'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""" General configuration
set cursorline                              " hilight cursor line
set more                                    " ---more--- like less
set number                                  " line numbers
set scrolloff=3                             " lines above/below cursor
set showcmd                                 " show cmds being typed
set title                                   " window title
set vb t_vb=                                " disable beep and flashing
set wildignore=.bak,.pyc,.o,.ojb,.a,
			\.pdf,.jpg,.gif,.png,
			\.avi,.mkv,.so               " ignore said files
set wildmenu                                " better auto complete
set wildmode=longest,list                   " bash-like auto complete

""" General settings {{{
set hidden                                      " buffer change, more undo
set history=1000                                " default 20
set iskeyword+=_,$,@,%,#                        " not word dividers
set laststatus=2                                " always show statusline
set linebreak                                   " don't cut words on wrap
set listchars=tab:>\                            " > to highlight <tab>
set list                                        " displaying listchars
set nolist                                      " wraps to whole words
set noshowmode                                  " hide mode cmd line
set noexrc                                      " don't use other .*rc(s)
set nostartofline                               " keep cursor column pos
set nowrap                                      " don't wrap lines
set numberwidth=5                               " 99999 lines
set splitbelow                                  " splits go below w/focus
set splitright                                  " vsplits go right w/focus
set ttyfast                                     " for faster redraws etc
set ttymouse=xterm2                             " experimental
syntax on                                       " add colorset syntax on
set background=dark
colorscheme monokai

""" Text formatting {{{
set autoindent                                  " preserve indentation
set backspace=indent,eol,start                  " smart backspace
set cinkeys-=0#                                 " don't force # indentation
set expandtab                                   " no real tabs
set ignorecase                                  " by default ignore case
set nrformats+=alpha                            " incr/decr letters C-a/-x
set shiftround                                  " be clever with tabs
set shiftwidth=4                                " default 8
set smartcase                                   " sensitive with uppercase
set smarttab                                    " tab to 0,4,8 etc.
set softtabstop=4                               " "tab" feels like <tab>
set tabstop=4                                   " replace <TAB> w/4 spaces

""" Toggle relativenumber using <leader>r {{{
""" Leader is '\'
nnoremap <leader>r :call RelNumberToggle()<CR>

function! RelNumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunction
"""}}}

""" Toggle number on and off using <leader>n {{{
nnoremap <leader>n :call NumberToggle()<CR>

function! NumberToggle()
    if(&number == 1)
        set nonumber
    else
        set number
    endif
endfunction
"""}}}

""" NerdTree conf
let NERDTreeIgnore = ['\.pyc$']
