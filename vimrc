set nocompatible

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('MarcWeber/vim-addon-mw-utils')
call dein#add('altercation/vim-colors-solarized')
call dein#source('vim-colors-solarized')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('danro/rename.vim')
call dein#add('ervandew/supertab')
call dein#add('godlygeek/tabular')
call dein#add('jgdavey/vim-blockle')
call dein#add('kchmck/vim-coffee-script')
call dein#add('kien/ctrlp.vim')
call dein#add('kien/rainbow_parentheses.vim')
call dein#add('mileszs/ack.vim')
call dein#add('rking/ag.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('thoughtbot/vim-rspec')
call dein#add('timcharper/textile.vim')
call dein#add('tomtom/tlib_vim')
call dein#add('tpope/vim-bundler')
call dein#add('tpope/vim-cucumber')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-surround')
call dein#add('troydm/pb.vim')
call dein#add('vim-ruby/vim-ruby')
call dein#add('vim-scripts/matchit.zip')
call dein#add('vim-scripts/tComment')
call dein#add('vim-scripts/CountJump')
call dein#add('vim-scripts/ingo-library')
call dein#add('vim-scripts/ConflictMotions')
call dein#add('vim-scripts/ConflictDetection')
call dein#add('rizzatti/dash.vim')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

syntax enable

set background=light

if has('gui_running')
    nnoremap <esc> :noh<return><esc>
else
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
endif

nnoremap <CR> :noh<CR><CR>

colorscheme solarized

filetype plugin on
filetype plugin indent on
set backspace=indent,eol,start
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set smarttab
set showmatch
set ruler
set incsearch
set number
set cursorline
set listchars=tab:‣\ ,eol:¬,trail:·,nbsp:□,extends:…
set list
set hidden
set noerrorbells
set visualbell
set laststatus=2
set ignorecase
set smartcase
set hls
set splitbelow
set splitright

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set wildignore+=.git,.svn,*/tmp/*,*.jpg,*.png,*.gif,*.jpeg,*.pyc

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_args='--except Metrics/LineLength -D'
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if has("gui_running")
    set guioptions=egmrt
    set guifont=Menlo\ Regular:h15.00
    set lines=44
    set co=146
endif

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! EnablePythonStyles()
  set shiftwidth=4 tabstop=4 shiftwidth=4 softtabstop=4
endfunction

if has("autocmd")
  autocmd BufWritePre *.scss,*.css,*.coffee,*.php,Gemfile,*.py,*.js,*.html,*.haml,*.rb,*.rake,*.feature,*.erb,*.sass :call <SID>StripTrailingWhitespaces()
  highlight BadWhitespace ctermbg=red guibg=red
  autocmd BufRead,BufNewFile *.scss,*.css,*.coffee*.php,Gemfile,*.py,*.js,*.rb,*.rake,*.feature,*.sass,*.erb,*.haml match BadWhitespace /\s\+$/
  autocmd BufRead,BufNewFile *.py :call EnablePythonStyles()

  augroup BWCCreateDir
      au!
      autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
  augroup END
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd BufNewFile,BufRead *.hamstache setf haml
  autocmd BufNewFile,BufRead *.csvbuilder,*.rabl,*.jbuilder setf ruby
end

set statusline=%<%f\ %h%m%r
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%=%-14.(%l,%c%V%)\ %P

command -nargs=+ PyAck Ack --python <q-args>
command -nargs=+ RAck Ack --ignore-dir=tmp --ignore-dir=public --ignore-dir=vendor <q-args>

command W w
command E e

command! -nargs=* Wrap set wrap linebreak nolist

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " let g:ctrlp_use_caching = 0
endif


:command Wd write|bdelete
