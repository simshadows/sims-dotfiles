--   file: init.lua
-- author: simshadows <contact@simshadows.com>

----------------------------------------------------------------------
-- PLUGINS -----------------------------------------------------------
----------------------------------------------------------------------

-- TODO


----------------------------------------------------------------------
-- GENERAL AND UI ----------------------------------------------------
----------------------------------------------------------------------

---- Automatically load in changes.
--vim.opt.autoread = true
-- TODO: This doesn't seem to work for me.

---- Line numbers
-- Show hybrid relative and absolute
vim.opt.number = true
vim.opt.relativenumber = true

---- Last line
-- Show current mode
--vim.opt.showmode = true
-- Show the partial command
--vim.opt.showcmd = true
-- TODO: Do these do anything?

-- Scrolloff ensures you can see extra lines below/above when scrolling up/down.
vim.opt.scrolloff = 7

---- Search Settings
-- Ignore case (Usually ignored. `smartcase` makes searches case sensitive.)
vim.opt.ignorecase = true
-- If the pattern contains an uppercase letter, it is case sensitive.
vim.opt.smartcase = true

-- Use system CLIPBOARD automatically when yanking/pasting.
vim.opt.clipboard = "unnamedplus,unnamed"

-- Horizontal splits split down
--vim.opt.splitbelow = true
-- Vertical splits split right
--vim.opt.splitright = true
-- TODO: Set these if needed

----------------------------------------------------------------------
-- TEXT --------------------------------------------------------------
----------------------------------------------------------------------

-- Wrap lines longer than the width of the window.
vim.opt.wrap = true
-- Long lines will continue from visually the same indent level
vim.opt.breakindent = true

-- TODO: adapt these to neovim if needed
---- Indentation
-- 1 tab == 4 spaces
--vim.opt.shiftwidth = 4
--vim.opt.tabstop = 4
-- Disable softtabstop. Such a confusing feature.
--vim.opt.softtabstop = 0
-- Insert spaces instead of tabs.
--vim.opt.expandtab = true
-- TODO: What does this do, and do I need it?
--vim.opt.smarttab = true

-- Automatic indent
vim.opt.autoindent = true
-- Smart indenting (TODO: Figure out the specifics of what this does.)
--vim.opt.smartindent = true

-- Stops automatically creating comment lines when creating a new line either
-- by line break or by use of o or O. As a result, you will have to add the
-- comment character yourself.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove {"c", "r", "o"}
    end
})

----------------------------------------------------------------------
-- SYNTAX HIGHLIGHTING, COLOURS, AND FONTS ---------------------------
----------------------------------------------------------------------

vim.cmd "colorscheme unokai"
-- Some alternatives that I also like:
--vim.cmd "colorscheme slate"
--vim.cmd "colorscheme retrobox"

-- Show tabs and trailing spaces
--vim.opt.list = true
--vim.opt.listchars = "tab:>-,trail:.,extends:>,precedes:<"
-- TODO: Figure out how to get the colours for this.

----------------------------------------------------------------------
-- STATUS LINE -------------------------------------------------------
----------------------------------------------------------------------

-- TODO

----------------------------------------------------------------------
-- KEY MAPPINGS ------------------------------------------------------
----------------------------------------------------------------------

-- TODO

