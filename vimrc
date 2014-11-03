set nocompatible

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
"
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'danro/rename.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jgdavey/vim-blockle'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'timcharper/textile.vim'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'troydm/pb.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/tComment'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"End NeoBundle Scripts-------------------------

" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()

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

set wildignore+=.git,.svn,tmp/**,*.jpg,*.png,*.gif,*.jpeg,*.pyc

let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_check_on_open=1

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

let g:syntastic_check_on_open=1

:command Wd write|bdelete
