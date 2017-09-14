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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set history=500

filetype plugin on
filetype indent on

" Automatically reads in changes if our buffer is unmodified and something else has modified it.
"set autoread

"let mapleader="\\"
"let g:mapleader="\\"
" TODO: Wait, what's the default? What happens if I delete this?

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Wrap lines longer than the width of the window.
set wrap

" Use spaces to indent instead of tabs
set expandtab

" TODO: What does this do, and do I need it? Once figured out, uncomment this.
"set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" TODO: What's the difference?

" Turn off automatic linen breaking
set textwidth=0

" Automatic indent
set autoindent
" Smart indenting (TODO: Figure out the specifics of what this does.)
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let $LANG='en'
"set langmenu=en

"" Line numbers
" Show hybrid relative and absolute
set number
set relativenumber
" Shows absolute line numbers in insert mode, and hybrid again once you leave it
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOURS AND FONTS """""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 colours palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
" TODO: I don't think I need this...

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
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Select all. Practically the same as Ctrl+a in graphical editors.
nnoremap <C-A> ggVG

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

