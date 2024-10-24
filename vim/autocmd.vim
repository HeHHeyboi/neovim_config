if argc() == 0
  augroup OpenOil
    autocmd!
  augroup END
endif

function! CheckCharAtCursor(s)
	execute "normal H"
    let curPos = getcurpos()
    let curCol = curPos[4]  " Column position is at index 4

    let line = getline(".")
	let char = line[curCol-1]
	let currentMode = mode()
	if char == 	a:s[0]
		execute "normal! ^df".a:s
		echo "delete"
	else
		execute "normal! I".a:s
		echo "add"
	endif

endfunction

" augroup filetype_cpp
" 	autocmd!
" 	autocmd FileType cpp,cs nnoremap <buffer> <C-k> :call CheckCharAtCursor("//")<cr>
" 	autocmd FileType cpp,cs vnoremap <buffer> <C-k> :call CheckCharAtCursor("//")<cr>
" augroup END
" Markdown file
augroup filetype_md
	autocmd!
	autocmd FileType markdown onoremap <buffer> ik :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^--\\+$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown onoremap <buffer> in@ :<c-u>execute "normal! /\\>.*@\rbviw"<cr>
augroup END
" Vimscript file
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
