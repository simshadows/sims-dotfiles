"   file: .vimrc
" author: https://github.com/simshadows
"
" Vim basic configuration.
"
" """"""""""""""""""""
" " Acknowledgements "
" """"""""""""""""""""
"
" As with many other vimrc files, this one attempts to combine bits
" and bobs from versions made by many others.
"
" In particular, I based the initial version on:
"     https://github.com/amix/vimrc
"
" """""""""""""
" " TODO List "
" """""""""""""
"
" Go back to lines 208-398 in:
"     https://github.com/amix/vimrc/blob/7fc202ec8895c564c10940a21af357d6c0665368/vimrcs/basic.vim
"

" Turns off Vi compatibility mode, which would otherwise have horrible default behaviour
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" VUNDLE BOILERPLATE CODE """

filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

""" INDIVIDUAL PLUGIN INSTALLATION """

" Dependencies

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" Functionality Plugins

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sleuth'
Plugin 'SirVer/ultisnips'
"Plugin 'mattn/emmet-vim'
Plugin 'lervag/vimtex'
"Plugin 'tpope/vim-fugitive'
"Plugin 'vim-syntastic/syntastic'

" Content Plugins

Plugin 'simshadows/vim-snippets' " My own fork

""" VUNDLE BOILERPLATE CODE """

call vundle#end()
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on

filetype on

""" PLUGIN SETTINGS """

let g:solarized_termtrans=1
let g:solarized_visibility="high"
set background=dark
colorscheme solarized

let g:vimtex_view_general_viewer="zathura"
"let g:vimtex_view_method="zathura"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL AND UI """"""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let $LANG='en'
"set langmenu=en

" Set command history
set history=500

filetype plugin on
filetype indent on

" Automatically load in changes.
set autoread

" Optimize for fast terminal connections
set ttyfast

let mapleader="\\"
let g:mapleader="\\"
" TODO: Why do we need g:mapleader?

" TODO: Add a sudo save command. amix's line66 has this.

" Turn off all backups
set nobackup
set nowb
set noswapfile
" TODO: Maybe turn it on and configure it to backup somewhere benign?

" Persistent Undo
"try
"   set undodir=/tmp/vimtmp/undodir
"   set undofile
"catch
"endtry
" TODO: Figure out how this works, and how to do it reliable cross-platform.

"" Line numbers
" Show hybrid relative and absolute
set number
set relativenumber
" Shows absolute line numbers in insert mode, and hybrid again once you leave it
"augroup numbertoggle
"    autocmd!
"    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

"" Last line
" Show current mode
set showmode
" Show the partial command
set showcmd

" Scrolloff ensures you can see extra lines below/above when scrolling up/down.
set scrolloff=7

" Enables Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" TODO: What exactly is the Wild menu?

" Always show the current position
set ruler

" Set command bar height
set cmdheight=1

" TODO: What does this do, and do I need it? Once figured out, uncomment this.
"set hid

" Makes backspace work as intended
"set backspace=eol,start,indent
"set whichwrap+=<,>,h,l
" TODO: Why is this needed? Once figured out, uncomment these.

"" Search Settings
" Ignore case (Usually ignored. `smartcase` makes searches case sensitive.)
set ignorecase
" If the pattern contains an uppercase letter, it is case sensitive.
set smartcase
" All matches are highlighted
set hlsearch
" Get search results as you enter the pattern.
set incsearch

" TODO: What is this and why should I uncomment it?
"set lazyredraw

" Enables regex
set magic

"" Show matching brackets when the text indicator is over them.
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" TODO: Doesn't seem to work. What does it do? Once figured out, uncomment these.

"" Removes annoying sounds
"set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500
" Properly disable sounds on errors on MacVim
"if has("gui_macvim")
"   autocmd GUIEnter * set vb t_vb=
"endif
" TODO: Maybe uncomment these as needed later.

" Add a margin to the left
"set foldcolumn=1

" Use system CLIPBOARD automatically when yanking/pasting.
set clipboard=unnamedplus
" Ideally, a clipboard manager should also synchronize the two
" clipboards.
" TODO: Why does "set clipboard+=unnamedplus" not work?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Wrap lines longer than the width of the window.
set wrap

" Long lines will continue from visually the same indent level
set breakindent

"" Indentation
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Disable softtabstop. Such a confusing feature.
set softtabstop=0
" Insert spaces instead of tabs.
set expandtab
" TODO: What does this do, and do I need it? Once figured out, uncomment this.
"set smarttab

" Turn off automatic linen breaking
set textwidth=0

" Automatic indent
set autoindent
" Smart indenting (TODO: Figure out the specifics of what this does.)
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOURS AND FONTS """""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable


" Set to 256 colours
set t_Co=256
"if $COLORTERM == 'gnome-terminal'
"    set t_Co=256
"endif
" TODO: Fix this up, make this more reliable...


" Configure list mode to show whitespace.
" (Enabling list mode is toggled. See keybindings section.)
set listchars=tab:»—,trail:·,extends:>,precedes:<

" Set colour scheme
"try
"   colorscheme desert
"catch
"endtry
" TODO: I think I'll roll with defaults for now. Maybe check out colours later.

" TODO: What is this?
set background=dark

" Set extra options when running in GUI mode
"if has("gui_running")
"   set guioptions-=T
"   set guioptions-=e
"   set t_Co=256
"   set guitablabel=%M\ %t
"endif
" TODO: Uncomment this later after figuring out what it does.

" Set encoding
set encoding=utf8
" TODO: Apparently, this also sets the language to en_US? How?

" Set unix as the standard file type when creating a new buffer.
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE """""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %-h%w\ \ %{HasPaste()}%F\ \ \ cwd:\ %{getcwd()}%=%a\ \ \ %b(0x%B)\ \ %l/%L\ \ %c\ \ %y%m%r\ \ 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Select all. Practically the same as Ctrl+a in graphical editors.
"nnoremap <C-A> ggVG
" Currently disabled since it jumps you to the end of the file.

" Semicolon now toggles paste mode
nnoremap ; :set list!<enter>

" Indenting/dedenting with < and > in visual mode no longer removes
" selection afterwards.
vnoremap < <gv
vnoremap > >gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HELPER FUNCTIONS """"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

