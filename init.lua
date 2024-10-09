vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

---------------------------------------------------
-- https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- Array of file names indicating root directory. Modify to your liking.
-- local root_names = { '.gitmodules', '.git', 'Makefile' }
--
-- -- Cache to use for speed up (at cost of possibly outdated results)
-- local root_cache = {}
--
-- local set_root = function()
--   -- Get directory path to start search from
--   local path = vim.api.nvim_buf_get_name(0)
--   if path == '' then return end
--   path = vim.fs.dirname(path)
--
--   -- Try cache and resort to searching upward for root directory
--   local root = root_cache[path]
--   if root == nil then
--     local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
--     if root_file == nil then return end
--     root = vim.fs.dirname(root_file)
--     root_cache[path] = root
--   end
--
--   -- Set current directory
--   vim.fn.chdir(root)
-- end
--
-- local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
-- vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
---------------------------------------------------

---------------------------------------------------
-- The plus register ("+") is the system clipboard. So this says we should use the system clipboard as the default for the unnamed register operations.
-- You need to make sure you have a clipboard provider installed on the system first, however. 
-- sudo apt update
-- sudo apt install xclip
-- echo "Hello from WSL" | xclip -selection clipboard
-- then here in nvim - :checkhealth clipboard
vim.opt.clipboard:append { 'unnamedplus' }

