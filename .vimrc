set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/

" Plugins ----------------- {{{
call vundle#begin()

" Requirement to use Vundle as vim plugin manager
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
" Bundle 'hdima/python-syntax'
" Bundle 'elzr/vim-json'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plugin 'plasticboy/vim-markdown'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
" Plugin 'hashivim/vim-vagrant'
Plugin 'pearofducks/ansible-vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tomasr/molokai'
call vundle#end()

" }}}

" Plugin settings for powerline ----------------- {{{
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
" }}}

" Plugin settings for Nerdtree ----------------- {{{
map F2 for Nerdtree
map <F2> :NERDTreeToggle<CR>
" }}}

" Trailing whitespace ------------- {{{
function! <SID>StripTrailingWhitespaces()
    if exists('b:noStripWhitespace')
        return
    endif
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
augroup allfiles_trailingspace
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
    autocmd FileType markdown let b:noStripWhitespace=1
augroup END
" }}}

filetype plugin indent on

" Syntax coloring ---------------- {{{
try
    set t_Co=256 " says terminal has 256 colors
    let g:molokai_original = 1
    let g:rehash256 = 1
    colorscheme molokai
catch
endtry
" }}}

" Highlights files past 120 colums in python
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

" augroup indentation_sr
"     autocmd!
"     autocmd BufRead,BufNewFile * setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
"     autocmd Filetype * setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
"     autocmd Filetype dot setlocal autoindent cindent
" augroup END

augroup indentation_dot
    autocmd!
    autocmd Filetype dot :setlocal autoindent cindent
augroup END

augroup TabsNotSpaces
    autocmd!
    autocmd BufRead,BufNewFile *.otl :setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
    autocmd BufRead,BufNewFile *GNUmakefile,*makefile,*Makefile :setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
augroup END
