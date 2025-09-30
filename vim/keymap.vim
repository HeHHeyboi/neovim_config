set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
let mapleader = "\<Space>"
" Normal mode mappings
" nnoremap <Tab> :tabnext<CR>

"nnoremap <Tab> <Plug>AirlineSelectNextTab
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" nnoremap <leader>Q :qall<CR>
" nnoremap <C-s> :w<CR>
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
" nnoremap <silent><leader>s :execute "split ".bufname("#")<cr> 
" nnoremap <silent><leader>v :"leftabove vsplit ".bufname("#")<cr>
" nnoremap <C-h> :noh<CR>:let @/=''<CR>
nnoremap <A-.> <C-w>5<
nnoremap <A-,> <C-w>5>
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

"autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^==|^--\\+$\r:nohlsearch\rkvg_"<cr>
"
inoremap kj <Esc>
"noremap kk <Esc>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
"or
"nnoremap <C-d> 15gjzz
"nnoremap <C-u> 15gkzz
" nnoremap <C-s> :w<CR>
"nnoremap <silent><leader>vh :execute "rightbelow vsplit " .bufname("#")<cr>
"nnoremap <silent><leader>vl :execute "leftabove vsplit " .bufname("#")<cr>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <C-h> :noh<CR>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
" nnoremap <silent><Tab> :tabnext<cr>
nnoremap <S-Tab> gT
nnoremap , @@
nnoremap <Leader>p "+p 
nnoremap <Leader>P k"+p 
nnoremap <silent><leader>y :set operatorfunc=YankOperator<cr>g@
function! YankOperator(type)
	if a:type ==# 'char'
		execute 'normal! `[v`]"+y'
	else
		return
	endif
endfunction
nnoremap vr :register<CR>
nnoremap vm :marks<CR>
nnoremap H ^
nnoremap L g_
"nnoremap ' :execute "normal! '" .nr2char(getchar()). " zz"<cr>

" }}}
"nnoremap r :execute 'normal! @'.nr2char(getchar())<CR>
"nnoremap <silent> dm :execute 'delmark '.nr2char(getchar())<CR>"

"
"Snippet--------------{{{

iabbrev @@    thanathatwave@gmail.com
"}}}

"Visual keymap-----------------{{{
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p 
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz
vnoremap H ^
vnoremap L g_
"}}}


