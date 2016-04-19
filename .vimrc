" Leader mappings -------------------- {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Display settings ------------ {{{
set wrap
set number

" Status bar
set statusline=%F
set statusline+=%=
set statusline+=%l
set statusline+=/
set statusline+=%L

" Set column to light grey at 80 characters
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif
" }}}
" Vundle --------------------- {{{
" Turn off important incompatibilities with vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Basics
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Rainbow
Plugin 'junegunn/rainbow_parentheses.vim'

" Basic coloring
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tomasr/molokai'

" Utils
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'szw/vim-maximizer'
Plugin 'dkprice/vim-easygrep'

" C-syntax
Plugin 'justinmk/vim-syntax-extra'

" Language-specific syntax
Plugin 'derekwyatt/vim-scala'
Plugin 'wting/rust.vim'
Plugin 'hdima/python-syntax'
Plugin 'autowitch/hive.vim'
Plugin 'elzr/vim-json'
Plugin 'vimoutliner/vimoutliner'
Plugin 'cespare/vim-toml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'plasticboy/vim-markdown'
Plugin 'klen/python-mode'

" Web Development - Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'mxw/vim-jsx'
Plugin 'groenewege/vim-less'

" Web Development - General
Plugin 'mattn/emmet-vim.git'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'pappasam/vim-ragtag'
Plugin 'KabbAmine/zeavim.vim'

call vundle#end()

filetype plugin indent on
" }}}
" Configure Rainbow ------------- {{{
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
augroup rainbow_settings
  " Section to turn on rainbow parentheses
  autocmd!
  autocmd FileType * RainbowParentheses
augroup END

" }}}
" Plugin constants ------------ {{{

" Set the javascript libraries that need syntax highlighting
let g:used_javascript_libs = 'jquery,requirejs,react'

" Python highlighting
let python_highlight_all = 1

" Plugin settings for python-mode
" Not fold by default
let g:pymode_folding = 0
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"

" Turn off code checking
let g:pymode_lint = 0

" Turn off regenerating project cache on every save (if file has been modified)
let g:pymode_rope_regenerate_on_write = 0

" Plugin settings for powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
"  }}}
" Filetypes ------------ {{{
augroup filetype_recognition
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
    autocmd BufNewFile,BufRead *.hql,*.q set filetype=hive
    autocmd BufNewFile,BufRead *.config set filetype=yaml
    autocmd BufNewFile,BufRead *.bowerrc set filetype=json
    au BufNewFile,BufRead *.handlebars set filetype=html
augroup END
" }}}
" General Key remappings ----------------------- {{{
" Enable movement within block of text
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$
" Autogenerate Parentheses, braces, and brackets
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR>	{<CR>}<Esc>O
inoremap [<CR>	[<CR>]<Esc>O
" Remap operators for doing things inserting in previous and next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
" Move line up and down with hyphen key
nnoremap - ddp
nnoremap _ ddkP
" Remap H and L to beginning and end of line
nnoremap H 0
nnoremap L $

" bind K to grep word under cursor
" nnoremap Z :vim "\b<C-R><C-W>\b"<CR>|cw<CR>
" }}}
" Access vimrc ------------------- {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
" }}}
" Vimscript file settings ------------------- {{{
augroup filetype_vim
	autocmd!
	autocmd BufWritePost *vimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevelstart=0
augroup END
" }}}
" Surround text ------------------ {{{
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" }}}
" Tabs and Windows ----------------- {{{
" Open new tab
nnoremap ;l :tabe . <ENTER>
nnoremap ;j :tabp <ENTER>
nnoremap ;k :tabn <ENTER>
" Change change window thorough Control + directional movement
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
" }}}
" Syntax coloring ---------------- {{{
try
    set t_Co=256 " says terminal has 256 colors
    let g:molokai_original = 1
    let g:rehash256 = 1
    colorscheme molokai
catch
endtry

" Set line number column color to grey
highlight LineNr ctermfg=grey

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
" Maximizer --------------- {{{
"silent! nnoremap <F5> :MaximizerToggle<CR>
"silent! vnoremap <F5> :MaximizerToggle<CR>gv
"silent! inoremap <F5> <C-o> :MaximizerToggle<CR>
"let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<F5>'
" }}}
" Nerdtree --------------- {{{
silent! nnoremap <C-p> :NERDTreeToggle<CR>
silent! noremap <F2> :NERDTreeToggle<CR>
silent! noremap <F3> :NERDTreeFind<CR>
let g:NERDTreeToggle="<F2>"
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
set wildignore+=*/target/*
" }}}
" Indentation ------------- {{{

" Note -> apparently BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosed with Filetype *
augroup indentation_sr
    autocmd!
    autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
    autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
    autocmd Filetype dot setlocal autoindent cindent
    autocmd BufRead,BufNewFile *.otl,*GNUmakefile,*makefile,*Makefile
          \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
augroup END
" }}}
" Writing ------------------ {{{
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1
augroup writing
    autocmd!
    autocmd FileType markdown :setlocal wrap linebreak nolist
    autocmd FileType markdown :setlocal colorcolumn=0
    autocmd BufNewFile,BufRead *.html,*.txt,*.tex :setlocal wrap linebreak nolist
    autocmd BufNewFile,BufRead *.html,*.txt,*.tex :setlocal colorcolumn=0
augroup END
" }}}
