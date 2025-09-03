# Neovim dotfiles

This `README.md` will serve as the user manual for my Neovim config and workflow to help me familiarize and refine.

To avoid the need to memorize motions, I lean a lot on [folke/which-key.nvim](https://github.com/folke/which-key.nvim) to list keybinds out for me.

## Things you should do on startup

**`<space>ss` - Reload last session for this CWD**

## Navigation: Basics

**`<C-u>` / `<C-d>` - Go half a page up/down**
- This is what I'm used to for fast scrolling in vi-style UI's.

**`<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` - Navigate splits**

**`<C-n>` / `<C-p>` - Navigate buffers**

**`gt` / `gT` - Navigate tabs**
- I don't make use of tabs, so I'm happy to keep it default.

## Navigation: Project and Filesystem

**`<space>q` - Show directory tree sidebar**
- Within the sidebar, `?` shows you keybinds for it.

**`<space>f` / `<space>g` / `<space>b` / `<space>h` - Quick fuzzy search for files/contents/buffers/help**

**`<space>F` / `<space>G` / `<space>B` / `<space>H` - Resume previous search**

## Code Helpers (Auto-Completion, LSP, Snippets, etc.)

**`<C-f>` (in insert mode) - Omni completion**

**`<tab>` (in insert mode) - Expand snippet (if the text is snippet-expandable)**

`;` is the lead key for all sorts of code help functions. My favourite one is: **`;;` - Hover**

## Misc

**`<space>a` will show keys for miscellaneous uncategorized things.**

## Appendix: Setting up dependencies

### fzf

<https://wiki.archlinux.org/title/Fzf>

### LSP Servers

- Typescript:
    - <https://github.com/yioneko/vtsls>

## Appendix: TODO

- Fold keybinds
- Refine my search tools
    - I need two broad categories of search functionality: 1) fast low-overhead search, and 2) a heavyweight solution suitable for long and complex engagements of raw string searches.
    - I'm currently using *fzf-lua* for my fast search needs.
    - **I'll still need to find a heavyweight solution.**
        - try out spectre
- Configure which-key with group descriptions.

## Appendix: References

- <https://neovim.io/doc/user/index.html>
    - Neovim official documentation
- Plugin aggregators:
    - <https://github.com/rockerBOO/awesome-neovim>
    - <https://dotfyle.com/neovim/plugins/top>

