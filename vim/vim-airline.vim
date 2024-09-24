"Vim airline
let g:airline_theme='raven'
"let g:airline_theme='atomic'
let g:airline_powerline_fonts = 1
let g:vsnip_filetypes = {}

"let g:airline_mode_map = {
"			\ '__'     : '-',
"			\ 'c'      : 'C',
"			\ 'i'      : 'Ins',
"			\ 'ic'     : 'Ins',
"			\ 'ix'     : 'Ins',
"			\ 'n'      : 'N',
"			\ 'multi'  : 'M',
"			\ 'ni'     : 'N',
"			\ 'no'     : 'N',
"			\ 'R'      : 'R',
"			\ 'Rv'     : 'R',
"			\ 's'      : 'S',
"			\ 'S'      : 'S',
"			\ ''     : 'S',
"			\ 't'      : 'T',
"			\ 'v'      : 'V',
"			\ 'V'      : 'V-Line',
"			\ ''     : 'V-Block',
"			\ }
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#branch#enabled=1

"let g:airline_section_a = airline#section#create(['mode',' ','branch'])
"let g:airline_section_b = airline#section#create(['%f'])
"let g:airline_section_c = airline#section#create(['%f','%n'])
"let g:airline_section_x = airline#section#create(['%Y','',''])
"let g:airline_section_y = airline#section#create(['fileformat'])
let g:airline_extensions = [ 'netrw']

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_right_sep = '«'

let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.maxlinenr = ''

let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'

let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = '⭤'
