-- Netrw settings
vim.g.netrw_banner = 0                -- Disable the banner for a cleaner look
vim.g.netrw_browse_split = 4          -- Open in prior window
vim.g.netrw_altv = 1                  -- Open splits to the right
vim.g.netrw_liststyle = 3             -- Tree-style listing
vim.g.netrw_winsize = 25              -- Set the window size to 25% of the Vim window
vim.g.netrw_preview = 1               -- Enable file previews
vim.g.netrw_keepdir = 0               -- Change to directory of file
vim.g.netrw_localcopydircmd = 'cp -r' -- Use 'cp -r' for copying directories

-- Define custom keybindings for Netrw
vim.cmd([[
  augroup NetrwMappings
    autocmd!
    autocmd FileType netrw nnoremap <buffer> <C-t> :tabedit<CR>
    autocmd FileType netrw nnoremap <buffer> <C-x> :split<CR>
    autocmd FileType netrw nnoremap <buffer> <C-v> :vsplit<CR>
    autocmd FileType netrw nnoremap <buffer> h :Rexplore<CR>
  augroup END
]])

-- Open parent directory with 'h'
vim.cmd([[
  augroup NetrwSettings
    autocmd!
    autocmd FileType netrw nmap <buffer> h -
  augroup END
]])

-- Toggle hidden files with 'H'
vim.g.netrw_list_hide = '.*\\.swp$,.*\\.bak$,.*\\.pyc$' -- Hide unwanted file types
vim.cmd('nmap <silent> <leader>n :call ToggleHideFiles()<CR>')

-- Function to toggle hidden files
function ToggleHideFiles()
	if vim.g.netrw_list_hide == '' then
		vim.g.netrw_list_hide = '.*'
	else
		vim.g.netrw_list_hide = ''
	end
	vim.cmd('edit') -- Refresh the view
end

vim.cmd('command! ToggleHiddenFiles call ToggleHideFiles()')

-- Avoid leaving netrw buffers open
vim.cmd([[
  augroup NetrwAutoClose
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe
  augroup END
]])

-- Auto-refresh netrw when switching between windows
vim.cmd([[
  augroup NetrwAutoRefresh
    autocmd!
    autocmd BufEnter * if &ft == 'netrw' | silent! execute ':silent! edit' | endif
  augroup END
]])
