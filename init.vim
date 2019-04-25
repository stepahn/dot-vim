if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'tpope/vim-sensible'

" editor
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-vinegar'
Plug 'machakann/vim-highlightedyank'
Plug 'kassio/neoterm'

" lib
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/CountJump'

" colors
Plug 'raichoo/monodark'
Plug 'brendonrapp/smyck-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'

" file
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
" Plug 'scrooloose/nerdtree'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/ConflictMotions'
Plug 'vim-scripts/ConflictDetection'

" editing
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'vim-scripts/matchit.zip'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'tag': '*', 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim', { 'tag': '*' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

if !has('nvim')
  Plug 'markonm/traces.vim'
endif

" filetypes
Plug 'timcharper/textile.vim'
Plug 'tpope/vim-haml'
Plug 'janko-m/vim-test'
Plug 'elixir-editors/vim-elixir'

" ruby
Plug 'NicolasWebDev/vim-blockle'
" Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'

" js
Plug 'kchmck/vim-coffee-script'

call plug#end()

function! <SID>StripTrailingWhitespaces() abort
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

nnoremap <silent> <CR> :noh<CR><CR>
nnoremap <silent> <C-J> <C-W><C-J>
nnoremap <silent> <C-K> <C-W><C-K>
nnoremap <silent> <C-L> <C-W><C-L>
nnoremap <silent> <C-H> <C-W><C-H>

tnoremap <Esc> <C-\><C-n>

colorscheme smyck

highlight Search guibg=NONE guifg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
highlight BadWhitespace ctermbg=red guibg=red

set autoindent
set cursorline
set expandtab
set exrc
set foldmethod=syntax
set guicursor=a:block-blinkon100-Cursor/Cursor
set hidden
set hlsearch
if has('nvim')
  set inccommand=nosplit
endif
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:⊙
set mouse=
set noerrorbells
set nofoldenable
set nojoinspaces
set number
set shiftwidth=2
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set visualbell
set wildignore+=.git,.svn,*/tmp/*,*.jpg,*.png,*.gif,*.jpeg,*.pyc

augroup commands
  au!
  au BufWritePre * :call <SID>StripTrailingWhitespaces()

  autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/

  autocmd BufReadPost fugitive://* setl bufhidden=delete

  autocmd BufNewFile,BufRead *.hamstache setf haml
  autocmd BufNewFile,BufRead *.csvbuilder,*.rabl,*.jbuilder,*.shaper setf ruby

  autocmd FileType python setl shiftwidth=4 tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType yaml setl foldmethod=indent

  " autocmd FileType netrw setl bufhidden=delete
augroup end

augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup end

command! W w
command! E e
command! -nargs=* Wrap set wrap linebreak nolist
command! Wd write|bdelete
command! TestFocus TestFile -t focus

let g:airline_powerline_fonts = 1

let g:ale_ruby_rubocop_options = '--except Metrics/LineLength -D -E'
let g:ale_haml_hamllint_options = '-x LineLength'
let g:ale_python_flake8_options = '--ignore=E501,C0301,C0111'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {
  \ 'python': ['flake8'] ,
  \ }

let g:ale_fixers = {
  \ 'ruby': ['rubocop'] ,
  \ }

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:deoplete#enable_at_startup = 1

" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
