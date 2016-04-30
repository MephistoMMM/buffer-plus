" a buffer plugin to make buffer contrl more powerful
" Maintainer: Mephis Pheies <mephistommm@gmail.com>	
" Last Change:  2016-03-15
" Version: 0.1.0
" License: MIT

if exists('g:BufferPlusLoaded') || &cp
  finish
end
let g:BufferPlusLoaded = 1

if !exists('g:BufferPlusChangeModeMap')
  let g:BufferPlusChangeModeMap = "<leader>bm"
end

if !exists('g:BufferPlusCloseMap')
  let g:BufferPlusCloseMap = "<C-g>"
end

if !exists('g:BufferPlusNewMap')
  let g:BufferPlusNewMap = "<C-t>"
end

if !exists('g:BufferPlusNextMap')
  let g:BufferPlusNextMap = "<C-n>"
end

if !exists('g:BufferPlusPrevMap')
  let g:BufferPlusPrevMap = "<C-p>"
end

if !exists('g:BufferPlusOtherCloseMap')
  let g:BufferPlusOtherCloseMap = "<leader>bc"
end

if !exists('g:BufferPlusOtherNewMap')
  let g:BufferPlusOtherNewMap = "<leader>bt"
end

if !exists('g:BufferPlusOtherNextMap')
  let g:BufferPlusOtherNextMap = "<leader>bn"
end

if !exists('g:BufferPlusOtherPrevMap')
  let g:BufferPlusOtherPrevMap = "<leader>bp"
endif

" 0 : CE mode
" 1 : SI mode
if !exists('g:BufferPlusDefaultMode') || g:BufferPlusDefaultMode != 1 || g:BufferPlusDefaultMode !=0
    let g:BufferPlusNowMode = 0
else
    let g:BufferPlusNowMode = g:BufferPlusDefaultMode
end


" TODO: 
"   - close the current window on many windows station
function! BufferPlusSafeCloseBufferInOneTag()
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

function! s:ChangeToSIMode()
        execute "nnoremap <silent> ".g:BufferPlusNewMap." :vne<CR>"
        execute "nnoremap <silent> ".g:BufferPlusPrevMap." :bp<CR>"
        execute "nnoremap <silent> ".g:BufferPlusNextMap." :bn<CR>"
        execute "nnoremap <silent> ".g:BufferPlusCloseMap." :call BufferPlusSafeCloseBufferInOneTag()<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherNewMap." :tabnew<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherPrevMap." :tabp<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherNextMap." :tabn<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherCloseMap." :close<CR>"
endfunction

function! s:ChangeToCEMode()
        execute "nnoremap <silent> ".g:BufferPlusNewMap." :tabnew<CR>"
        execute "nnoremap <silent> ".g:BufferPlusPrevMap." :tabp<CR>"
        execute "nnoremap <silent> ".g:BufferPlusNextMap." :tabn<CR>"
        execute "nnoremap <silent> ".g:BufferPlusCloseMap." :close<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherNewMap." :vne<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherPrevMap." :bp<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherNextMap." :bn<CR>"
        execute "nnoremap <silent> ".g:BufferPlusOtherCloseMap." :call BufferPlusSafeCloseBufferInOneTag()<CR>"
endfunction

function! s:BufferPlusChangeMode()
    if g:BufferPlusNowMode == 0
        call s:ChangeToCEMode()
    else 
        call s:ChangeToSIMode()
    end
endfunction

function! BufferPlusModeStatusChange()
    if g:BufferPlusNowMode == 0 
        let g:BufferPlusNowMode = 1
    else 
        let g:BufferPlusNowMode = 0
    end
    call s:BufferPlusChangeMode()
endfunction

function! BufferPlusModeString()
    if g:BufferPlusNowMode == 0
        return "CE"
    else
        return "SI"
    end
endfunction

function! BufferPlusInit()
    " let map them
    execute "nnoremap <silent> ".g:BufferPlusChangeModeMap." :call BufferPlusModeStatusChange()<CR>"
    call s:BufferPlusChangeMode()
endfunction

au BufEnter * :call BufferPlusInit()


