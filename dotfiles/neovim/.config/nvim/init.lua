--   file: init.lua
-- author: simshadows <contact@simshadows.com>

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

----------------------------------------------------------------------
-- PLUGIN SPECS ------------------------------------------------------
----------------------------------------------------------------------

local plugin_specs = {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "https://github.com/neovim/nvim-lspconfig"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
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
                    additional_vim_regex_highlighting = {
                        "markdown",
                    },

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
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
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
    -- I'm not sure which file browser to use.
    -- For now, I prefer Neotree due to saner keybinds, but Neotree is buggier.
    -- nvim-tree is more stable but I don't know how to change keybinds.
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
    --{
    --    "nvim-tree/nvim-tree.lua",
    --    config = function()
    --        require("nvim-tree").setup({
    --            --on_attach = function()
    --            --    local api = require "nvim-tree.api"
  
    --            --    local function opts(desc)
    --            --      return {
    --            --          desc = "nvim-tree: " .. desc,
    --            --          buffer = bufnr,
    --            --          noremap = true,
    --            --          silent = true,
    --            --          nowait = true
    --            --      }
    --            --    end
  
    --            --    api.config.mappings.default_on_attach(bufnr)
    --            --    vim.keymap.set(
    --            --        'n',
    --            --        '<C-t>',
    --            --        api.tree.change_root_to_parent,
    --            --        opts('Up')
    --            --    )
    --            --    vim.keymap.set(
    --            --        'n',
    --            --        '?',
    --            --        api.tree.toggle_help,
    --            --        opts('Help')
    --            --    )
  
    --            --end,
    --            sort = {
    --                sorter = "case_sensitive",
    --            },
    --            view = {
    --                width = 30,
    --            },
    --            renderer = {
    --                group_empty = true,
    --            },
    --            filters = {
    --                dotfiles = true,
    --            },
    --        })
    --    end,
    --},
    {
        "https://github.com/ThePrimeagen/harpoon"
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {},
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip").setup({})
            -- I'm preferring to use VSCode-format snippets for compatibility
            --require("luasnip.loaders.from_snipmate").lazy_load({
            --    paths = {"~/.common-resources/snippets-snipmate"}
            --})
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {"~/.common-resources/snippets-vscode"}
            })
        end
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
    checker = {
        enabled = false
    },
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

vim.cmd([[ colorscheme unokai ]])
-- Some alternatives that I also like:
--vim.cmd "colorscheme slate"
--vim.cmd "colorscheme retrobox"

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = {
    tab = "\u{2192} ",
    trail = "\u{B7}",
    extends = ">",
    precedes = "<",
}
-- And set the colour of this
vim.api.nvim_set_hl(0, "NonText", {fg = "#525043"})

-- Also highlight "sus characters" (mostly non-ASCII and control characters)
vim.api.nvim_set_hl(0, "SusCharacter", {bg = "yellow", fg = "red", ctermbg = "yellow", ctermfg = "red"})
vim.api.nvim_create_autocmd(
    {"BufEnter", "BufReadPost"},
    {
        pattern = "*",
        callback = function()
            -- If it's a normal buffer
            if vim.bo.buftype == "" then
                -- Do highlighting
                vim.cmd([[ syn match SusCharacter /[^\x09-\x7E]/ ]])
                vim.cmd([[ syn match SusCharacter /[\x0A-\x1F]/  ]])
            end
        end
    }
)

vim.cmd("au BufNewFile,BufRead *.ejs set filetype=html")

vim.cmd("au BufNewFile,BufRead *.txt.ejs set filetype=text")
vim.cmd("au BufNewFile,BufRead *.ts.ejs set filetype=typescript")
vim.cmd("au BufNewFile,BufRead *.js.ejs set filetype=javascript")
vim.cmd("au BufNewFile,BufRead *.tsx.ejs set filetype=typescriptreact")
vim.cmd("au BufNewFile,BufRead *.jsx.ejs set filetype=javascriptreact")
vim.cmd("au BufNewFile,BufRead *.json.ejs set filetype=json")

vim.cmd("au BufNewFile,BufRead *.mdx set filetype=markdown")

----------------------------------------------------------------------
-- STATUS LINE -------------------------------------------------------
----------------------------------------------------------------------

--vim.opt.statusline = " %-h%w  %{HasPaste()}cwd: %{getcwd()}   %F%=%a   %b(0x%B)  %l/%L  %c  %y%m%r  "
vim.opt.statusline = " %-h%w  cwd: %{getcwd()}   %F%=%a   %b(0x%B)  %l/%L  %c  %y%m%r  "

-- TODO: My original .vimrc has more stuff to it. I should adapt it.
--       It handled netrw and "paste mode".

----------------------------------------------------------------------
-- LSP ---------------------------------------------------------------
----------------------------------------------------------------------

-- npm install -g @astrojs/language-server
--vim.lsp.enable("astro")
-- TODO: This doesn't work for me for some reason.

----------------------------------------------------------------------
-- KEY MAPPINGS ------------------------------------------------------
----------------------------------------------------------------------

-- We make basic navigation keybinds available in normal and insert mode
function setNavigationKeybind(key, cmd, desc)
    local fullDesc = "Navigate " .. desc
    local iCmd = "<Esc>" .. cmd;
    vim.keymap.set("n", key, cmd, {desc = fullDesc})
    vim.keymap.set("i", key, iCmd, {desc = fullDesc})
end
setNavigationKeybind("<C-n>", ":bnext<enter>",             "buffers: next")
setNavigationKeybind("<C-p>", ":bprevious<enter>",         "buffers: previous")
setNavigationKeybind("<C-x>", ":bp | sp | bn | bd<enter>", "buffers: close buffer without closing window")
setNavigationKeybind("<C-k>", "<C-w>k", "splits: up")
setNavigationKeybind("<C-h>", "<C-w>h", "splits: down")
setNavigationKeybind("<C-h>", "<C-w>h", "splits: left")
setNavigationKeybind("<C-l>", "<C-w>l", "splits: right")
--setNavigationKeybind("<C-n>", "gt", "tabs: next")
--setNavigationKeybind("<C-p>", "gT", "tabs: previous")

vim.keymap.set("n", "<leader>K", "<C-w>+",
    {desc = "Split Height Increase"}
)
vim.keymap.set("n", "<leader>J", "<C-w>-",
    {desc = "Split Height Decrease"}
)
vim.keymap.set("n", "<leader>H", "<C-w><",
    {desc = "Split Width Decrease"}
)
vim.keymap.set("n", "<leader>L", "<C-w>>",
    {desc = "Split Width Increase"}
)

vim.keymap.set("v", ">", ">gv",
    {desc = "Increase indent without losing the selection"}
)
vim.keymap.set("v", "<", "<gv",
    {desc = "Decrease indent without losing the selection"}
)

vim.keymap.set(
    "n",
    "<leader>f",
    function()
        require("fzf-lua").files()
    end,
    {desc = "Find files [fzf-lua]"}
)
vim.keymap.set(
    "n",
    "<leader>g",
    function()
        require("fzf-lua").live_grep_native()
        -- Alternatively, there's live_grep(), but do you ever need it?
        --require("fzf-lua").live_grep()
    end,
    {desc = "Find in contents (live grep) [fzf-lua]"}
)
vim.keymap.set(
    "n",
    "<leader>b",
    function()
        require("fzf-lua").buffers()
    end,
    {desc = "Find buffers [fzf-lua]"}
)
vim.keymap.set(
    "n",
    "<leader>h",
    function()
        require("fzf-lua").helptags()
    end,
    {desc = "Find in help tags [fzf-lua]"}
)
--vim.keymap.set(
--    "n",
--    "<leader>r",
--    function()
--        require("fzf-lua").resume()
--    end,
--    {desc = "(Experimental)"}
--)


vim.keymap.set("n", "<leader>q", ":Neotree<enter>",
    --":NvimTreeOpen<enter>",
    {desc = "Open File Browser"}
)
--vim.keymap.set(
--    "n",
--    "<leader><leader>",
--    ":Neotree close<enter>",
--    --":NvimTreeToggle<enter>",
--    {desc = "Close File Browser"}
--)


vim.keymap.set(
    "n",
    "<leader>1",
    function()
        require("harpoon.ui").nav_prev()
    end,
    {desc = "[harpoon] Navigate to prev mark"}
)
vim.keymap.set(
    "n",
    "<leader>2",
    function()
        require("harpoon.ui").toggle_quick_menu()
    end,
    {desc = "[harpoon] Toggle quick menu"}
)
vim.keymap.set(
    "n",
    "<leader>3",
    function()
        require("harpoon.ui").nav_next()
    end,
    {desc = "[harpoon] Navigate to next mark"}
)
vim.keymap.set(
    "n",
    "<leader>4",
    function()
        require("harpoon.mark").add_file()
    end,
    {desc = "[harpoon] Mark"}
)


vim.keymap.set(
    "n",
    "<leader>ss",
    function()
        require("persistence").load()
    end,
    {desc = "[persistence.nvim] Load the session for the current directory"}
)
vim.keymap.set(
    "n",
    "<leader>sS",
    function()
        require("persistence").select()
    end,
    {desc = "[persistence.nvim] Select a session to load"}
)
vim.keymap.set(
    "n",
    "<leader>sl",
    function()
        require("persistence").load({ last = true })
    end,
    {desc = "[persistence.nvim] Load the last session"}
)
vim.keymap.set(
    "n",
    "<leader>sd",
    function()
        require("persistence").stop()
    end,
    {desc = "[persistence.nvim] Stop. (Session won't be saved on exit.)"}
)

vim.keymap.set(
    "i",
    "<tab>",
    function()
        local luasnip = require("luasnip")
        if luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
        else
            local key = vim.api.nvim_replace_termcodes("<tab>", true, false, true)
            vim.api.nvim_feedkeys(key, 'n', false)
        end
    end
    --{silent = true}
)
-- TODO: What about backwards and other functions?

vim.keymap.set(
    "n",
    ";s",
    ":%s///g<left><left><left>",
    {desc = "Substitute text (global)"}
)
-- A version that will only replace within a visual selection:
-- (Note that the '<,'> part is automatically added in.)
--vim.keymap.set(
--    "v",
--    ";s",
--    ":s///g<left><left><left>",
--    {desc = "Substitute text within visual selection"}
--)
-- TODO: This doesn't seem to work. 
-- TODO: Maybe it's better to just use something like:
--           :%s//g<left><left>
--       since it results in fewer keystrokes.

vim.keymap.set("n", ";c", ":noh<enter>",
    {desc = "Clear highlighting"}
)

