set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"" VUNDLE
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/Vim/vimfiles/bundle/Vundle.vim
let path='~/Vim/vimfiles/bundle'
call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Color Schemes
Plugin 'flazz/vim-colorschemes'

" Static Analysis
Plugin 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list=1

" Cucumber
Plugin 'tpope/vim-cucumber'

" Auto insert end after if, do, def and the likes for various languages
Plugin 'tpope/vim-endwise'

" Auto enclose things
Plugin 'tpope/vim-surround'

" HTML
Plugin 'mattn/emmet-vim'

" Elixir
Plugin 'elixir-lang/vim-elixir'

" Typescript
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction



"" Compiling
" Per-file-type definitions for           RUN        REPL      DEBUG
au BufNewFile,BufRead *.m   let b:comp  = ["octave", "octave", "octave"]
au BufNewFile,BufRead *.py  let b:comp  = ["python", "python", "python -m pdb"]
au BufNewFile,BufRead *.pl  let b:comp  = ["perl",   "perl",   "perl -d"]
au BufNewFile,BufRead *.rb  let b:comp  = ["ruby",   "irb",    "ruby -rdebug"]
au BufNewFile,BufRead *.exs let b:comp  = ["elixir", "iex",    "elixir -d"]
au BufNewFile,BufRead *.ex  let b:comp  = ["elixir", "iex",    "elixir -d"]
au BufNewFile,BufRead *.hs  let b:comp  = ["runghc", "ghci",   "runghc"]
au BufNewFile,BufRead *.ts  let b:comp  = ["tsc",    "tsc",    "tsc -d"]

nmap <Leader>r :exec "!" b:comp[0] " %"<cr>
nmap <Leader>i :exec "!" b:comp[1]<cr>
nmap <Leader>d :exec "!" b:comp[2] " %"<cr>

"" OTHER
set nobackup

"" STYLING
syntax enable
set background=light
colorscheme solarized
set guifont=Lucida_Console:h10:cANSI
set showmatch " Show matching brackets
set mat=5 "Bracket blinking
set laststatus=2 "Always show status line
set lcs=trail:~ " Show trailing spaces as ~

"" FORMATTING
set nu " Line numbering
set ts=2 " Tabs are 2 spaces
set bs=2 " Backspace over everything in insert mode
set shiftwidth=2 "Tabs are 2 spaces for smart indenting
set autoindent
set smartindent
set expandtab " Expand tabs to spaces

"" KEY MAPPING
" auto-center things
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap { {zz
nmap } }zz

"quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>{ {}<ESC>i
imap <leader>[ []<ESC>i
imap <leader>< <><ESC>i
