--   file: init.lua
-- author: simshadows <contact@simshadows.com>

----------------------------------------------------------------------
-- PLUGIN SPECS ------------------------------------------------------
----------------------------------------------------------------------

local plugin_specs = {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "astro",
                    "c",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "query",
                    "typescript",
                    "vim",
                    "vimdoc",
                },

                auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,

                    -- Disable treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                highlight = {"Whitespace", "CursorColumn"},
                char = "",
            },
            whitespace = {
                highlight = {"Whitespace", "CursorColumn"},
                remove_blankline_trail = false,
            },
            scope = {
                enabled = true,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        },
    },
}

----------------------------------------------------------------------
-- BOOTSTRAP PLUGIN MANAGER ------------------------------------------
----------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = plugin_specs,
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

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

---- Indentation
-- 1 tab == 4 spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- Disable softtabstop. Such a confusing feature.
vim.opt.softtabstop = 0
-- Insert spaces instead of tabs.
vim.opt.expandtab = true
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

--vim.opt.statusline = " %-h%w  %{HasPaste()}cwd: %{getcwd()}   %F%=%a   %b(0x%B)  %l/%L  %c  %y%m%r  "
vim.opt.statusline = " %-h%w  cwd: %{getcwd()}   %F%=%a   %b(0x%B)  %l/%L  %c  %y%m%r  "

-- TODO: My original .vimrc has more stuff to it. I should adapt it.
--       It handled netrw and "paste mode".

----------------------------------------------------------------------
-- KEY MAPPINGS ------------------------------------------------------
----------------------------------------------------------------------

vim.keymap.set(
    "n",
    "<C-p>",
    "gT",
    {desc = "Navigate Tab Left"}
)
vim.keymap.set(
    "n",
    "<C-n>",
    "gt",
    {desc = "Navigate Tab Right"}
)
vim.keymap.set(
    "n",
    "<C-k>",
    "<C-w>k",
    {desc = "Navigate Split Up"}
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<C-w>j",
    {desc = "Navigate Split Down"}
)
vim.keymap.set(
    "n",
    "<C-h>",
    "<C-w>h",
    {desc = "Navigate Split Left"}
)
vim.keymap.set(
    "n",
    "<C-l>",
    "<C-w>l",
    {desc = "Navigate Split Right"}
)

vim.keymap.set(
    "n",
    "<leader>p",
    "gT",
    {desc = "Navigate Tab Previous"}
)
vim.keymap.set(
    "n",
    "<leader>n",
    "gt",
    {desc = "Navigate Tab Next"}
)
vim.keymap.set(
    "n",
    "<leader>k",
    "<C-w>k",
    {desc = "Navigate Split Up"}
)
vim.keymap.set(
    "n",
    "<leader>j",
    "<C-w>j",
    {desc = "Navigate Split Down"}
)
vim.keymap.set(
    "n",
    "<leader>h",
    "<C-w>h",
    {desc = "Navigate Split Left"}
)
vim.keymap.set(
    "n",
    "<leader>l",
    "<C-w>l",
    {desc = "Navigate Split Right"}
)

vim.keymap.set(
    "n",
    "<leader>K",
    "<C-w>+",
    {desc = "Split Height Increase"}
)
vim.keymap.set(
    "n",
    "<leader>J",
    "<C-w>-",
    {desc = "Split Height Decrease"}
)
vim.keymap.set(
    "n",
    "<leader>H",
    "<C-w><",
    {desc = "Split Width Decrease"}
)
vim.keymap.set(
    "n",
    "<leader>L",
    "<C-w>>",
    {desc = "Split Width Increase"}
)


local telescopeBuiltin = require("telescope.builtin")

vim.keymap.set(
    "n",
    "<leader>ff",
    telescopeBuiltin.find_files,
    {desc = "Telescope find files"}
)
vim.keymap.set(
    "n",
    "<leader>fg",
    telescopeBuiltin.live_grep,
    {desc = "Telescope live grep"}
)
vim.keymap.set(
    "n",
    "<leader>fb",
    telescopeBuiltin.buffers,
    {desc = "Telescope buffers"}
)
vim.keymap.set(
    "n",
    "<leader>fh",
    telescopeBuiltin.help_tags,
    {desc = "Telescope help tags"}
)


vim.keymap.set(
    "n",
    "<leader>q",
    ":Neotree<enter>",
    {desc = "Open Neotree"}
)

