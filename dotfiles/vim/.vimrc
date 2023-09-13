"   file: .vimrc
" author: https://github.com/simshadows
"
" Vim basic configuration.
"
" ====================
" = Acknowledgements =
" ====================
"
" As with many other vimrc files, this one attempts to combine bits
" and bobs from versions made by many others.
"
" In particular, I based the initial version on:
"     https://github.com/amix/vimrc
"
" =============
" = TODO List =
" =============
"
" Go back to lines 208-398 in:
"     https://github.com/amix/vimrc/blob/7fc202ec8895c564c10940a21af357d6c0665368/vimrcs/basic.vim
"

" Add to runtimepath
set runtimepath^=~/.vim/custom-runtime/

" Turns off Vi compatibility mode, which would otherwise have horrible default behaviour
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" VUNDLE BOILERPLATE CODE (1 of 2) """

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
" (These are here since the other plugins won't work without them.)

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" General Functionality Plugins

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sleuth'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
"Plugin 'mattn/emmet-vim'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'tpope/vim-fugitive'
"Plugin 'vim-syntastic/syntastic'
Plugin 'vim-utils/vim-troll-stopper'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wincent/command-t'

" Functionality Plugins (for specific workflows)

Plugin 'leafgarland/typescript-vim'
Plugin 'wuelnerdotexe/vim-astro'
Plugin 'lervag/vimtex'
" vim-mdx-js is old. Need to find an actively maintained plugin.
Plugin 'jxnblk/vim-mdx-js'

" TODO: We should get rid of directly using ultisnips now since we have coc.
"       The problem is, I'm still not sure how to configure coc for tab autocompletion.
Plugin 'SirVer/ultisnips'

" Conflicts...
"Plugin 'tpope/vim-surround'

" Content Plugins

Plugin 'honza/vim-snippets'

""" VUNDLE BOILERPLATE CODE (2 of 2) """

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

let g:coc_global_extensions = [
    \ "coc-tsserver",
    \ "coc-snippets"]

nmap ;; :call CocActionAsync('doHover')<CR>

" We're not using this right now since we're still using ultisnips directly.
" " Trigger snippet expand.
" "imap <C-l> <Plug>(coc-snippets-expand)
" " TODO: What's the difference between expand and expand-jump?
" " TODO: What does coc-snippets-select do?
" vmap <C-l> <Plug>(coc-snippets-select)
" imap <C-l> <Plug>(coc-snippets-expand-jump)
" " Next/previous placeholder
" let g:coc_snippet_next = '<c-l>'
" let g:coc_snippet_prev = '<c-h>'

" These keys trigger UltiSnips commands in insert mode.
" NOTE: <C-L> should still usable if you use 'set insertmode'.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" Aliases
"inoremap <expr> <C-J> UltiSnips#JumpForwards()
"inoremap <expr> <C-K> UltiSnips#JumpBackwards()
" TODO: These are bugged. Find a better alternative...

" Show indentation
let g:indent_guides_enable_on_vim_startup = 1
" TODO: Make this look better?
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black

" Set unicode characters to be highlighted
" TODO: How do I use this?
"highlight TrollStopper ctermbg = red guibg = #FF0000

nnoremap ;g :CommandT<enter>

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
set backspace=eol,start,indent
set whichwrap+=<,>
" TODO: Should I add other options such as b, s, [, and ]?

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
set clipboard=unnamedplus,unnamed
" Ideally, a clipboard manager should also synchronize the two
" clipboards.
" TODO: Why does "set clipboard+=unnamedplus" not work?
" TODO: I originally had just 'unnamedplus' but it wouldn't work on mac, so
"       I added ',unnamed'. What other implications does this have?

" Horizontal splits split down
set splitbelow
" Vertical splits split right
set splitright
" Also note: vim horizontal splits are like tmux/i3 vertical splits, and vice versa.

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

" Stops automatically creating comment lines when creating a new line either
" by line break or by use of o or O. As a result, you will have to add the
" comment character yourself.
autocmd FileType * set formatoptions-=cro
" TODO: Why doesn't 'set formatoptions-=cro' on its own work in vimrc?
"       It works when entering it in manually...

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING, COLOURS, AND FONTS """""""""""""""""""""""""""
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
set listchars=tab:>-,trail:.,extends:>,precedes:<

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

" Changes default highlighting of *.ejs files
" EJS templating can be anything, but HTML has been a good default for me.
au BufNewFile,BufRead *.ejs set filetype=html

au BufNewFile,BufRead *.txt.ejs set filetype=text
au BufNewFile,BufRead *.ts.ejs set filetype=typescript
au BufNewFile,BufRead *.js.ejs set filetype=javascript
au BufNewFile,BufRead *.tsx.ejs set filetype=typescriptreact
au BufNewFile,BufRead *.jsx.ejs set filetype=javascriptreact
au BufNewFile,BufRead *.json.ejs set filetype=json
"" using astro for mdx is a reasonable fallback
" au BufNewFile,BufRead *.mdx set filetype=astro

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE """""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line conditionally depending on file type.
"set statusline=\ %-h%w\ \ %{HasPaste()}cwd:\ %{getcwd()}\ \ \ %F%=%a\ \ \ %b(0x%B)\ \ %l/%L\ \ %c\ \ %y%m%r\ \ 

set statusline=%!StatusLine()
" Shows different status line depending on file type.
function! StatusLine()
    if &ft == 'netrw'
        " netrw
        let b:status = "\ %-h%w\ \ %F%=%a\ \ \ %b(0x%B)\ \ %l/%L\ \ %c\ \ %y%m%r\ \ "
    else
        " DEFAULT
        let b:status = "\ %-h%w\ \ %{HasPaste()}cwd:\ %{getcwd()}\ \ \ %F%=%a\ \ \ %b(0x%B)\ \ %l/%L\ \ %c\ \ %y%m%r\ \ "
    endif
    return b:status
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS """"""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" See ':h index' to find default functions.

" ------------
" --- Meta ---
" ------------

" Leader Key
let mapleader="\\"
let g:mapleader="\\"
" TODO: Why do we need g:mapleader?

" In addition to this, I use two more keys as "meta-keys", i.e. keys that
" give access to further commands. These keys are:
"   s   Used for navigating splits and tabs. Mappings are similar to tmux.
"           MNEMONIC: "Split"
"   ;   Used for other functions that don't quite neatly fit anywhere.

" ------------------
" --- Navigation ---
" ------------------

" As much as I want to love the existing tag navigation keys, they absolutely suck.

" Tag Navigation
" Jump to tag
nnoremap <c-h> <c-T>
" Unbound (for now)
nnoremap <c-j> <Nop>
" List the tag stack
nnoremap <c-k> :tags<enter>
" Jump to previous tag (from the tag stack)
nnoremap <c-l> <c-]>

" List the jump stack
nnoremap ;j :jumps<enter>

" For future use...
"nnoremap H <Nop>
"nnoremap K <Nop>
"nnoremap L <Nop>

" ---------------
" --- Editing ---
" ---------------

" Indenting/dedenting with < and > in visual mode no longer removes
" selection afterwards.
vnoremap < <gv
vnoremap > >gv

" Shortcut for writing a global substitute command.
" It's up to you to then fill it out to complete it.
" I use it so much that it seems stupid to me not to have one.
" Example: :%s/oldtext/newtext/g
nnoremap ;s :%s///g<left><left><left>
" A version that will only replace within a visual selection:
" (Note that the '<,'> part is automatically added in.)
vnoremap ;s :s///g<left><left><left>
" MNEMONIC: "Substitute"
" TODO: Maybe it's better to just use something like:
"           :%s//g<left><left>
"       since it results in fewer keystrokes.

" TODO: Add something for ':g/'?

" Shortcut for sorting a selection by alphabetical order.
nnoremap ;o :sort u<enter>

" <C-U> or <C-W> in insert mode deletes text with no way of undoing. <C-U> in
" particular is frequently accidentally done when attempting to scroll up or
" down. I don't even use these keys in insert mode anyway.
inoremap <C-U> <Nop>
inoremap <C-W> <Nop>

nnoremap ;t :call ConvertTabsTo4Spaces()<CR>

" ------------------
" --- UI: Splits ---
" ------------------

" WEIRDNESS: These remappings don't seem to work with netrw...
" TODO: Fix this.

" Easier splits creation, and more conformant to tmux and i3.
" These split the current file then goes to it (since it doesn't by default):
nnoremap s% :vsp<enter><C-L>
nnoremap s" :sp<enter><C-L>
" NOTE: Assumes:
"           set splitbelow
"           set splitright

" These make a netrw split:
" (No need to add <C-L> or <C-J> since we automatically go to it.)
nnoremap s5 :Vex<enter>
nnoremap s' :Sex<enter>

" Easier splits navigation.
nnoremap sj <C-W><C-J>
nnoremap sk <C-W><C-K>
nnoremap sl <C-W><C-L>
nnoremap sh <C-W><C-H>

" Easier splits resizing.
nnoremap sJ <C-W>-
nnoremap sK <C-W>+
nnoremap sL <C-W>>
nnoremap sH <C-W><
" WEIRDNESS: These don't expand the splits by direction like you'd expect.
"            For each orientation (horizontal/vertical), one key expands the
"            current pane in that orientation while the other shrinks it.
"            What you end up with is behaviour where windows don't expand
"            or shrink in the direction you expect it to.
" TODO: Fix that weirdness maybe?

" ----------------
" --- UI: Tabs ---
" ----------------

" WEIRDNESS: These remappings don't seem to work with netrw...
" TODO: Fix this.

" Creates a tab that clones the current window
nnoremap sc :tab split<enter>
" Creates a netrw tab
nnoremap sC :Tex<enter>

" Easier tab navigation
nnoremap sp :tabprevious<enter>
nnoremap sn :tabnext<enter>

" -----------------
" --- UI: Other ---
" -----------------

" Display tabs and leading spaces.
nnoremap ;l :set list!<enter>
" I use this so much to inspect whitespace that it deserves this prime real estate.

" Remove search highlighting.
nnoremap ;c :noh<enter>
" MNEMONIC: "Clear" highlight

" Makes it so pasting in visual mode will replace the visual selection
" WITHOUT YANKING THE REPLACED TEXT. (Upper-case P will continue to be available
" for that functionality.)
vnoremap p "_dP

" The manpage key
" I don't use it (I prefer using another terminal), but I guess it might
" be useful someday?
nnoremap ;m K

" -------------
" --- netrw ---
" -------------

" TODO: Figure out the cleanest way to remap things specifically for
"       netrw and help filetypes without affecting everything else.
"       'help' filetype mappings desired:
"           nnoremap q :q<enter>
"       'netrw' filetype mappings desired:
"           nnoremap q :q<enter>
"           nnoremap L <enter>
"           nnoremap H /^\.\.\/$<enter><enter>

" (This remapping attempt will not switch back for other types on other panes.)
"autocmd FileType netrw nnoremap q :q<enter>

" --------------
" --- Others ---
" --------------

" Allows you to sudo-write.
cmap w!! w !sudo tee > /dev/null %
" BUG: Sometimes, 'w!!' will fail to change to expand to the actual command.
"      However, if you've already used it in the session, you can just
"      press up-arrow to go through the command buffer.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NETRW CONFIG """"""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Removes the huge useless banner.
let g:netrw_banner = 0
" NOTE: It can still be viewed with the 'I' key, but why would you need it...

" Display style
let g:netrw_liststyle = 0
" NOTE: This can be changed with the 'i' key.

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

function! ConvertTabsTo4Spaces()
    set tabstop=4
    set shiftwidth=4
    set expandtab
    retab
    return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEMPORARY """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" I'm trying to diagnose vim's slowness, and profiling shows matchparen
" to be the most significant culprit. However, disabling it doesn't feel
" to have worked. Also, I have no idea what matchparen is used for.
"let loaded_matchparen = 1

