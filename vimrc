

"
set encoding=utf-8
set nocompatible
set expandtab
set sts=2
set tabstop=2
syntax enable
"set number
set autoindent
set foldmethod=manual
set shiftwidth=2
filetype plugin indent on
autocmd FileType javascript set autoindent shiftwidth=4 softtabstop=4 expandtab
autocmd FileType erb        set autoindent shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html       set autoindent shiftwidth=4 softtabstop=4 expandtab
autocmd FileType haml       set autoindent shiftwidth=2 softtabstop=2 expandtab
autocmd FileType sass       set autoindent shiftwidth=4 softtabstop=4 expandtab
autocmd FileType ruby,css   set autoindent shiftwidth=2 softtabstop=2 expandtab
autocmd FileType java       set autoindent shiftwidth=4 softtabstop=4 expandtab

" Go fmt uses tabs instead of spaces
autocmd FileType go         set noexpandtab tabstop=4 shiftwidth=4
"autocmd FileType ruby,sass set autoindent shiftwidth=4 softtabstop=4 expandtab

"Interpret .md as markdown so apostrophes do not show up as a start of string
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.jinja2 set filetype=html
autocmd BufNewFile,BufRead *.vue set filetype=typescript

"Interpret .slim as slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim



" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase smartcase		" Do case insensitive matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all mod
set foldlevel=99
set autoread    " Automaticall load changes to files (why isn't this working?)


" Use the system clipboard to hold all buffers
set clipboard+=unnamed

" Autosave when focus lost
" :au FocusLost * :wa
autocmd BufLeave,FocusLost * wall

" ****************************************

" see https://github.com/tpope/vim-pathogen for how to install pathogen
"call pathogen#infect()
"call pathogen#helptags()

" not working:
" map <F2> :NERDTreeToggle<CR>
"
" also not working:
" nmap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>
"
" Save file with either semicolon or colon
nnoremap ; :

" Leader
:let mapleader=","

" Highlight trailing whitespace
" match Todo /\s\+$/
" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e


" GoLang
" `go fmt` on save (causes problems on workspaces)
"autocmd BufWritePre *.go :silent! execute '!go fmt %'
"
"if exists("g:did_load_filetypes")
"  filetype off
"  filetype plugin indent off
"endif
"set runtimepath+=/usr/local/go/misc/vim
"filetype plugin indent on
"syntax on

" auto-save
"let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" Automatically set spelling on certain file types
autocmd BufNewFile,BufRead *.txt set spell
autocmd BufNewFile,BufRead *.jd  set spell





" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END



" Slim see https://github.com/slim-template/vim-slim
syntax enable
filetype plugin indent on

" Slim see https://github.com/slim-template/vim-slim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" NOTE You must run :PluginInstall from inside vim to actually install these
" vundle plugins

Plugin 'gmarik/Vundle.vim'
"Plugin 'slim-template/vim-slim.git'
"Plugin 'https://github.com/psf/black.git'
"Plugin 'codota/tabnine-vim'
"autocmd BufWritePre *.py execute ':Black'

Plugin 'dense-analysis/ale'
call vundle#end()

"Note ruff tells you if annotations missing, but
"pyright can also tell you if you are calling function with incorrect type
" using mypy instead of pyright because pyright is not working on
" workspaces....possibly because node/npm not installed
let g:ale_linters = {'python': ['ruff']}
"let g:ale_linters = {'python': ['ruff', 'mypy']}
"
"let g:ale_fixers = {'python': ['isort', 'black', 'ruff']}
let g:ale_fixers = {'python': ['ruff']}
"let g:ale_fixers = {'python': ['ruff_format', 'ruff']}
" Force ruff to use the config in my home directory (because otherwise it
" appears to only look in the current directory for config)
"
" This is commented out so it hopefully defaults to project directory
" let g:ale_python_ruff_options = '--config ~/pyproject.toml'
let g:ale_fix_on_save = 1




" Tread hyphens like underscores
set iskeyword+=-
