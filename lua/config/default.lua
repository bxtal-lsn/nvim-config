vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":luaCR>")
vim.g.have_nerd_font = true
vim.o.cmdheight = 0
-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false

if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
	-- Check if the path exists
	local win32yank_path = "/mnt/c/Users/bl/scoop/shims/win32yank.exe"
	if vim.fn.executable(win32yank_path) == 1 then
		vim.opt.clipboard = "unnamedplus"
		vim.g.clipboard = {
			name = "win32yank",
			copy = {
				["+"] = win32yank_path .. " -i --crlf",
				["*"] = win32yank_path .. " -i --crlf",
			},
			paste = {
				["+"] = win32yank_path .. " -o --lf",
				["*"] = win32yank_path .. " -o --lf",
			},
			cache_enabled = 0,
		}
	end
end

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.o.ruler = false
vim.opt.scrolloff = 15

-- [[ Basic Keymaps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreview<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_set_keymap("n", "<leader><tab>", "<C-^>", { noremap = true, silent = true })

vim.opt.hlsearch = true
vim.opt.laststatus = 2
vim.opt.wildmenu = true

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Open a new flotterm
vim.api.nvim_set_keymap("n", "<leader>ft", ":FloatermNew<CR>", { noremap = true, silent = true })

-- Toggle the terminal
vim.api.nvim_set_keymap("n", "<leader>t", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })

-- Navigate between floaterms
vim.api.nvim_set_keymap("n", "<leader>fn", ":FloatermNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fp", ":FloatermPrev<CR>", { noremap = true, silent = true })

-- Kill floaterm instance
vim.api.nvim_set_keymap("n", "<leader>fk", ":FloatermKill<CR>", { noremap = true, silent = true })

-- Close terminal with ESC in terminal mode
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.g.floaterm_autoinsert = true
vim.g.floaterm_borderchars = "─│─│┌┐┘└"
