" Don't try to be vi compatible
set nocompatible

set belloff=all" set ; as leader

let mapleader=";"

call plug#begin('~/.config/nvim/plugged')
	Plug 'mhartington/oceanic-next'
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

	" typescript highlights
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

" https://robindouglas.uk/powershell/vim/2018/04/05/PowerShell-with-Vim.html
set shell=powershell.exe
set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
set shellpipe=|
set shellredir=>

" Enable Windows clipboard copy/paste
" source $VIMRUNTIME/mswin.vim

let g:airline_powerline_fonts=1
let g:airline_solarized_bg='dark'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if(has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme OceanicNext

" neovim
" set active buffer as the root of the nerdtree
set autochdir
let NERDTreeChDirMode=2

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <leader>nn :NERDTreeMirror<CR>:NERDTreeFocus<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
" map ctrl+b to toggle nerd tree
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>


" integrated terminal
" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+;
function! OpenTerminal()
  split term:\\powershell
  resize 10
endfunction
nnoremap <C-;> :call OpenTerminal()<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


" fzf
nnoremap <C-p> :FZF<CR>
" let g:fzf_action = {
 " \ '<leader>ot': 'tab split',
 " \ '<leader>oh': 'split',
 " \ '<leader>ov': 'vsplit'
 " \}


au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

let g:ale_linters = {
\   'javascript': ['eslint']
\}
let g:ale_fixers = {
  \    'javascript': ['eslint'],
  \    'typescript': ['prettier', 'tslint'],
  \    'react': ['eslint'],
  \    'css': ['prettier'],
  \    'scss': ['prettier'],
  \    'html': ['prettier'],
\}

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio']
    \ }

nnoremap <leader>l :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>


" be aware that you cant add comments AFTER your mapping. 
" it will be counted as mapping instructions. Therefore comments are on line before.

" so backspace functions normally
set backspace=indent,eol,start

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

set tabstop=2
set shiftwidth=2

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

:vnoremap H ^
:vnoremap L $
:vnoremap ^ <nop>
:vnoremap g_ <nop>

" yank until the end of line - put all yanked items to 'n' registry
" to avoid conflict with delete, cut, replace, sub etc
:nnoremap <Leader>Y "nyg_
:vnoremap <Leader>Y "nyg_

" yank until the beginning of line
:nnoremap <Leader>y "n^
:vnoremap <Leader>y "n^

" map redo to U because i need ctrl key in visual studio
:nnoremap U <C-R>

:nnoremap <Leader>v <C-v>

" map undo all for the line to leader u, i dont use it much but still
:nnoremap <Leader>u U

" to ensure delete (d/D) doesn't overwrite what was yanked.
" always yank, cut, and paste from non-default registry
:nnoremap p "np
:nnoremap P "nP
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
