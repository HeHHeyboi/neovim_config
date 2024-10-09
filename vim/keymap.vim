set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
" Normal mode mappings
nnoremap <Tab> :tabnext<CR>

"nnoremap <Tab> <Plug>AirlineSelectNextTab
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-q> :bd<CR>
"nnoremap bn :bnext<CR>
"nnoremap bN :bprevious<CR>
nnoremap g. :bnext<CR>
nnoremap g, :bprevious<CR>
nnoremap <leader>ev :split ~/.vimrc<cr>
nnoremap <leader>ei :split $MYVIMRC<cr>
" nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
" vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>
"nnoremap <silent><leader>vl :execute "rightbelow vsplit " .bufname("#")<cr>
"nnoremap <silent><leader>vh :execute "leftabove vsplit " .bufname("#")<cr>
"nnoremap <silent><leader>sj :execute "botright split " .bufname("#")<cr>
"nnoremap <silent><leader>sk :execute "topleft split " .bufname("#")<cr>
nnoremap <silent><leader>s :execute "split ".bufname("#")<cr> 
nnoremap <silent><leader>v :execute "rightbelow vsplit ".bufname("#")<cr>
nnoremap <C-h> :noh<CR>:let @/=''<CR>
nnoremap <A-,> <C-w>5<
nnoremap <A-.> <C-w>5>
nnoremap <A-=> <C-w>+
nnoremap <A--> <C-w>-

onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>

" vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>
function! GrepOperator(type)
	let saved_unnamed_register = @@
	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	silent execute "grep! " . shellescape(@@)

	let @@ = saved_unnamed_register
	copen
endfunction
