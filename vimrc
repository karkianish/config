" be aware that you cant add comments AFTER your mapping. 
" it will be counted as mapping instructions. Therefore comments are on line before.

" Don't try to be vi compatible
set nocompatible

set belloff=all

" so backspace functions normally
set backspace=indent,eol,start

" set ; as leader
let mapleader=";"

" enable syntax highlighting
syntax on

" refresh my vimrc
command! RV source $MYVIMRC <bar> echo "refreshed vimrc!"

" launch vimrc for editing
:nnoremap <leader><leader><leader> :vsplit $MYVIMRC<cr>

" use system clipboard to paste items copied outside of vim i.e. default register will be *
set clipboard=unnamed

" Show line numbers
set number

" Show file stats
set ruler

" wrap after 80 char width is reached
set wrap
set textwidth=80

" set the cursor where it was before yanking in visual mode
:vnoremap y "nygv<ESC>

" map jj to esc - just using inoremap because we need this feature only in insert mode
:inoremap jj <ESC>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" clear search
map <leader>c :let @/=''<cr>

"nmap - normal mode map
"imap - insert mode map

:nnoremap H ^
:nnoremap L $
:nnoremap ^ <nop>
:nnoremap g_ <nop>

" leader j will join lines since we used J for 5j
" :nnoremap <Leader>j J

" yank until the end of line - put all yanked items to 'n' registry
" to avoid conflict with delete, cut, replace, sub etc
:nnoremap Y "nyg_
:vnoremap Y "nyg_

" yank until the beginning of line
:nnoremap <Leader>y "n^
:vnoremap <Leader>y "n^

" map redo to U because i need ctrl key in visual studio
:nnoremap U <C-R>

" map undo all for the line to leader u, i dont use it much but still
:nnoremap <Leader>u U

" to ensure delete (d/D) doesn't overwrite what was yanked.
" always yank, cut, and paste from non-default registry
:nnoremap p "np
:nnoremap P "np
:vnoremap p "np
:vnoremap P "nP

:nnoremap y "ny
:nnoremap Y "nY
:vnoremap y "ny
:vnoremap Y "nY

:nnoremap x "nx
:nnoremap X "nX
:vnoremap x "nx
:vnoremap X "nX

" to actually use cut/delete, use in combination with leader 
" need to use * instead of " (default register) because
" i had it set up to use system register somewhere above in this file
:nnoremap <leader>p "*p
:nnoremap <leader>P "*p
:vnoremap <leader>p "*p
:vnoremap <leader>P "*P

" so that I can have access to yanked items outside vim
:nnoremap <leader>y "*y
:nnoremap <leader>Y "*Y
:vnoremap <leader>y "*y
:vnoremap <leader>Y "*Y

" search highlighted text with //
" source: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
