set nocompatible              " be iMproved, required
filetype off                  " required
set shortmess+=I              " disable startup message

" use indents of 4 spaces
set shiftwidth=4

" tabs are spaces, not tabs
set expandtab

" an indentation every four columns
set tabstop=4

" let backspace delete indent
set softtabstop=4

" enable auto indentation
set autoindent

" automatically remove trailing spaces and ^M characters
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2
"
" " Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256
set term=screen-256color

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
call vundle#end()            
filetype plugin indent on

" lifted from https://github.com/codegram/vimfiles/blob/master/vimrc
"
set statusline=%F%m%r%h%w[%L]%y[%p%%][%04v] "[%{fugitive#statusline()}]
" | | | | | | | | | | |
" | | | | | | | | | | + current
" | | | | | | | | | | column
" | | | | | | | | | +-- current line
" | | | | | | | | +-- current % into file
" | | | | | | | +-- current syntax in
" | | | | | | | square brackets
" | | | | | | +-- current fileformat
" | | | | | +-- number of lines
" | | | | +-- preview flag in square brackets
" | | | +-- help flag in square brackets
" | | +-- readonly flag in square brackets
" | +-- rodified flag in square brackets
" +-- full path to file in the rbuffer
"}

" options for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
" color overrides
highlight SyntasticErrorSign ctermfg=red ctermbg=237
highlight SyntasticWarningSign ctermfg=yellow ctermbg=237
highlight SyntasticStyleErrorSign ctermfg=red ctermbg=237
highlight SyntasticStyleWarningSign ctermfg=yellow ctermbg=237

" git-gutter http://git.io/vimgitgutter
" speed optimizations
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'
" custom symbols
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'
" color overrrides
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=237
highlight GitGutterChange ctermfg=yellow ctermbg=237
highlight GitGutterDelete ctermfg=red ctermbg=237
highlight GitGutterChangeDelete ctermfg=red ctermbg=237

" Colors **********************************************************************
"set t_Co=256 " 256 colors
"set background=dark
syntax on " syntax highlighting
"colorscheme synic
"colorscheme vimbrant_cli
"colorscheme lokaltog
"colorscheme zenburn
colorscheme molokai
highlight Comment cterm=bold
