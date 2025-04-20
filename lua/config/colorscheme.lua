local cmd = vim.cmd

-- NOTE: Highlight LineNr for kanagawa
-- cmd("hi CursorLine   cterm=NONE guibg=#292e3b guifg=NONE")
-- 252a35, 2e3646, 2a313d, 282735,292e3b

-- NOTE: Highlight LineNr for ayu-mirage
-- cmd("hi CursorLine   cterm=NONE guibg=#292f3e guifg=NONE")
-- cmd("hi CursorLine   cterm=NONE guibg=#2d3344 guifg=NONE")
-- cmd("hi CursorLine   cterm=NONE guibg=#343b4d guifg=NONE")
-- cmd("hi CursorLine   cterm=NONE guibg=#3a4256 guifg=NONE")
-- cmd("hi CursorLine   cterm=NONE guibg=#313847 guifg=NONE ") -- or 292f3e, 2d3344, 343b4d,3a425h,313847

cmd("hi CursorLineNr cterm=NONE guifg=#ffc300 guibg=NONE gui=bold")
cmd("highlight LineNr guifg=#8aa7cf")
cmd("highlight TabLine guibg=#3E4452 guifg=#ABB2BF")
cmd("highlight TabLineSel guibg=#61AFEF guifg=#282C34 gui=bold")
cmd("highlight TabLineFill guibg=#282C34 guifg=#ABB2BF")
