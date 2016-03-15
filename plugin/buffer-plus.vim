" a buffer plugin to make buffer contrl more powerful
" Maintainer: Mephis Pheies <mephistommm@gmail.com>	
" Last Change:  2016-03-15
" Version: 0.1.0
" License: MIT

if exists('g:BufferPlusLoaded') || &cp
  finish
end
let g:BufferPlusLoaded = 1

if !exists('g:BufferPlusSafeCloseMap')
  let g:BufferPlusSafeCloseMap = "<C-c>"
end

if !exists('g:BufferPlusNewBufferMap')
  let g:BufferPlusNewBufferMap = "<C-t>"
end

" TODO: 
"   - close the current window on many windows station
function! SafeCloseBufferInOneTag()
    let nowNumber = bufnr("%")

    " u tag buffer need be close
    if buflisted(nowNumber) == 0
        execute 'close'
    end
    
    let nextNumber = bufnr("#")

    if nextNumber > 0 && nextNumber != nowNumber
        execute 'bn'
        execute 'bw '.nowNumber
    else
        echo "This is the last buffer!"
    end
endfunction

function! BufferPlusInit()
    " let map them
    execute "nnoremap <silent> ".g:BufferPlusNewBufferMap." :new<CR><C-W>j:close<CR>"
    execute "nnoremap <silent> ".g:BufferPlusSafeCloseMap." :call SafeCloseBufferInOneTag()<CR>"
endfunction

au BufEnter * :call BufferPlusInit()


