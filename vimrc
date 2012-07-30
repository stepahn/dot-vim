call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set smarttab
set showmatch
set nocompatible
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

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1


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
  autocmd BufWritePre *.php,Gemfile,*.py,*.js,*.html,*.haml,*.rb,*.feature,*.erb,*.sass :call <SID>StripTrailingWhitespaces()
  highlight BadWhitespace ctermbg=red guibg=red
  autocmd BufRead,BufNewFile *.php,Gemfile,*.py,*.js,*.rb,*.rake,*.feature,*.sass,*.erb,*.haml match BadWhitespace /\s\+$/
  autocmd BufRead,BufNewFile *.py :call EnablePythonStyles()

  augroup BWCCreateDir
      au!
      autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
  augroup END
  autocmd BufReadPost fugitive://* set bufhidden=delete
end

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

command W w
