
" Set the custom tabline
set tabline=%!MyTabLine()

" Function to get the label of the tab
function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return expand('#' . buflist[winnr - 1] . ':~:.'.a:n)
endfunction

" Function to build the custom tabline
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " Select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " Set the tab page number (for mouse clicks)
        let s .= '%' .. (i + 1) .. 'T'

        " The label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' .. (i + 1) .. ')} '
    endfor

    " After the last tab fill with TabLineFill and reset tab page number
    let s .= '%#TabLineFill#%T'

    " Right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction
