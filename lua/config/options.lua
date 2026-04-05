vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = ""
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = false
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	callback = function()
		vim.o.number = true
		vim.o.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(function()
            vim.cmd("terminal")
            vim.cmd("startinsert")
        end)
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})
vim.api.nvim_create_autocmd("TermLeave", {
    callback = function()
        local pid = vim.b.terminal_job_pid
        if pid then
            local cwd = vim.fn.system("readlink -f /proc/" .. pid .. "/cwd"):gsub("\n", "")
            vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
        end
        vim.wo.number = true
        vim.wo.relativenumber = true
    end,
})

