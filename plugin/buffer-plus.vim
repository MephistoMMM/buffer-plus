" a buffer plugin to make buffer contrl more powerful
" Maintainer: Mephis Pheies <mephistommm@gmail.com>	
" Last Change:  2016-03-15
" Version: 0.1.0
" License: MIT

function! SafeCloseBufferInOneTag()
    let nowNumber = bufnr("%")
    execute 'bn<CR>'
    execute 'bw '.nowNumber
endfunction


