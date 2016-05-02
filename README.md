Buffer Plus
==========
a buffer plugin to make buffer contrl more powerful

[Mephis Pheies' blog](http://mephistopheies.me/2016/03/15/wo-xie-de-buffer-pluscha-jian/) show more details.

Installation
------------
copy plugin/buffer-plus.vim to ~/.vim/plugin

or if you are using `pathogen`:

```git clone git://github.com/MephistoMMM/buffer-plus.git ~/.vim/bundle/buffer-plus```

Features
--------

* safe close buffer while only one tag on vim
* defined two mode 
    * CE, (code edit)
    * SI, (source insight)
* change mode between CE and SI
* change main control map prefix keys

while you change mode between CE and SI , your main control map keys of file stream contrl (new, next, preview, close) will not change !
.e.g: 

    default: <C-n> --> :tabnext<CR> in CE , <C-n> --> :bn<CR> in SI

Usage
--------

someone using vim is conditioned to control buffer while other controling tag. e.g. emacser like buffer.

Thus there is two perferences :

* perferences 'buffer'
* perferences 'tag'

You could change it by 
    
    set g:BufferPlusPerf = 'taga'      " default 'buffer'

In 'buffer' perferences, your main control map prefix keys is 'Control', while assistant control map prefix keys being '<leader>'
In 'tag' perferences your main control map prefix keys is '<leader>', while assistant control map prefix keys being 'Control'

example:

In 'tag' :

```
use '\<leader\>bm' to change mode 

use '\<C-t\>' to create new tab(buffer in SI)

use '\<C-n\>' to change to next tab(buffer in SI)

use '\<C-p\>' to change to preview tab(buffer in SI)

use '\<C-c\>' to close tab(buffer in SI)

use '\<leader\>bt' to create new buffer(tab in SI)

use '\<leader\>bn' to change to next buffer(tab in SI)

use '\<leader\>bp' to change to preview buffer(tab in SI)

use '\<leader\>bd' to close buffer(tab in SI)
```

if you use airline plugin, you are able to call BufferPlusModeString() , it return the string of current mode ('CE' or 'SI'), like me:
   
    let g:airline_section_a = airline#section#create(['mode', '❀ ','%{BufferPlusModeString()} ','branch'])


Option
-------

####g:BufferPlusPerf 
define preference 'buffer' or 'tag' (default: 'buffer')

####g:BufferPlusDefaultMode
define default mode, 0 == CE mode, 1 == SI mode (default: 0) 

####g:BufferPlusChangeModeMap 
change mode (default: '\<leader\>bm')

####g:BufferPlusCloseMap
close the tab in CE (buffer in SI) (default: '\<C-c\>')

####g:BufferPlusNewMap
create new tab in CE (buffer in SI) (default: '\<C-t\>')

####g:BufferPlusNextMap
chagne to next tab in CE (buffer in SI) (default: '\<C-t\>')

####g:BufferPlusPrevMap
chagne to preview tab in CE (buffer in SI) (default: '\<C-t\>')

####g:BufferPlusOtherCloseMap
create new buffer in CE (tab in SI) (default: '\<leader\>bd')

####g:BufferPlusOtherNewMap
create new buffer in CE (tab in SI) (default: '\<leader\>bt')

####g:BufferPlusOtherNextMap
chagne to next buffer in CE (tab in SI) (default: '\<leader\>bn')

####g:BufferPlusOtherPrevMap
chagne to preview buffer in CE (tab in SI) (default: '\<leader\>bp')



License
-------

Copyright (C) 2016-2018 Mephis Pheies

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
