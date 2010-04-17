syntax on
colorscheme vividchalk
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
set listchars=tab:‣\ ,eol:¬
set list
set hidden
set noerrorbells
set laststatus=2

nnoremap <esc> :noh<return><esc>

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

if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.html,*.haml,*.rb,*.feature,*.erb,*.sass :call <SID>StripTrailingWhitespaces()
  highlight BadWhitespace ctermbg=red guibg=red
  autocmd BufRead,BufNewFile *.rb,*.rake,*.feature,*.sass,*.erb,*.haml match BadWhitespace /[\s\t]+$/
end
