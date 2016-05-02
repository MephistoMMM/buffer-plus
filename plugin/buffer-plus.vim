" a buffer plugin to make buffer contrl more powerful
" Maintainer: Mephis Pheies <mephistommm@gmail.com>	
" Last Change:  2016-03-15
" Version: 0.1.0
" License: MIT

if exists('g:BufferPlusLoaded') || &cp
  finish
endif
let g:BufferPlusLoaded = 1

function! s:isIn(variable, ...)
  let s:count = 1
  while s:count <= a:0
    if a:variable == a:{s:count}
      return 1
    endif
  endwhile
  return 0
endfunction

let s:buffers = {'close': '<leader>bd', 'new': '<leader>bt', 'next': '<leader>bn', 'prev': '<leader>bp'}
let s:tags = {'close': '<C-c>', 'new': '<C-t>', 'next': '<C-n>', 'prev': '<C-p>'}

function! s:getKeysValueAccordingTo(perf, keyname)
  " if not find keyname in map, return '<M-x>'
  " a joke for emacs users
  if a:perf == 'buffer'
    return get(s:buffers, a:keyname, '<M-x>')
  else
    return get(s:tags, a:keyname, 'M-x')
  endif
endfunction

" user have two perferences to choose
" buffer for emacser or buffer liker
" "
if !exists('g:BufferPlusPerf') || !s:isIn(g:BufferPlusPerf, "tag", "buffer") || g:BufferPlusPerf == "buffer"
  let g:BufferPlusPerf = "buffer"
  let g:BufferPlusDisl = "tag"
else
  let g:BufferPlusPerf = "tag"
  let g:BufferPlusDisl = "buffer"
endif

if !exists('g:BufferPlusChangeModeMap')
  let g:BufferPlusChangeModeMap = "<leader>bm"
endif

if !exists('g:BufferPlusCloseMap')
  let g:BufferPlusCloseMap = s:getKeysValueAccordingTo(g:BufferPlusPerf, 'colse')
endif

if !exists('g:BufferPlusNewMap')
  let g:BufferPlusNewMap = s:getKeysValueAccordingTo(g:BufferPlusPerf, 'new')
endif

if !exists('g:BufferPlusNextMap')
  let g:BufferPlusNextMap = s:getKeysValueAccordingTo(g:BufferPlusPerf, 'next')
endif

if !exists('g:BufferPlusPrevMap')
  let g:BufferPlusPrevMap = s:getKeysValueAccordingTo(g:BufferPlusPerf, 'prev')
endif

if !exists('g:BufferPlusOtherCloseMap')
  let g:BufferPlusOtherCloseMap = s:getKeysValueAccordingTo(g:BufferPlusDisl, 'colse')
endif

if !exists('g:BufferPlusOtherNewMap')
  let g:BufferPlusOtherNewMap = s:getKeysValueAccordingTo(g:BufferPlusDisl, 'new')
endif

if !exists('g:BufferPlusOtherNextMap')
  let g:BufferPlusOtherNextMap = s:getKeysValueAccordingTo(g:BufferPlusDisl, 'next')
endif

if !exists('g:BufferPlusOtherPrevMap')
  let g:BufferPlusOtherPrevMap = s:getKeysValueAccordingTo(g:BufferPlusDisl, 'prev')
endif

" 0 : CE mode
" 1 : SI mode
if !exists('g:BufferPlusDefaultMode') || !s:isIn(g:BufferPlusDefaultMode, 1, 0)
    let g:BufferPlusNowMode = 0
else
    let g:BufferPlusNowMode = g:BufferPlusDefaultMode
endif


" TODO: 
"   - close the current window on many windows station
function! BufferPlusSafeCloseBufferInOneTag()
    let nowNumber = bufnr("%")

    " u tag buffer need be close
    if buflisted(nowNumber) == 0
        execute 'close'
    endif
    
    let nextNumber = bufnr("#")

    if nextNumber > 0 && nextNumber != nowNumber
        execute 'bn'
        execute 'bw '.nowNumber
    else
        echo "This is the last buffer!"
    endif
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
    endif
endfunction

function! BufferPlusModeStatusChange()
    if g:BufferPlusNowMode == 0 
        let g:BufferPlusNowMode = 1
    else 
        let g:BufferPlusNowMode = 0
    endif
    call s:BufferPlusChangeMode()
endfunction

function! BufferPlusModeString()
    if g:BufferPlusNowMode == 0
        return "CE"
    else
        return "SI"
    endif
endfunction

function! BufferPlusInit()
    " let map them
    execute "nnoremap <silent> ".g:BufferPlusChangeModeMap." :call BufferPlusModeStatusChange()<CR>"
    call s:BufferPlusChangeMode()
endfunction

au BufEnter * :call BufferPlusInit()


