set encoding=utf-8
set nocompatible
set expandtab
set sts=2
set tabstop=2
syntax on
"set number
set autoindent
set foldmethod=syntax
set shiftwidth=2
filetype plugin indent on
autocmd FileType javascript set autoindent shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html set autoindent shiftwidth=4 softtabstop=4 expandtab
autocmd FileType sass set autoindent shiftwidth=4 softtabstop=4 expandtab
autocmd FileType ruby,css set autoindent shiftwidth=2 softtabstop=2 expandtab
autocmd FileType golang set autoindent shiftwidth=2 softtabstop=2
"autocmd FileType ruby,sass set autoindent shiftwidth=4 softtabstop=4 expandtab


" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" every time an upgrade of the vim packages is performed.  It is recommended to
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

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
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

call pathogen#infect()
call pathogen#helptags()

" not working:
" map <F2> :NERDTreeToggle<CR>
"
" also not working:
" nmap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>
"
nnoremap ; :

" Leader
:let mapleader=","

" Highlight trailing whitespace
" match Todo /\s\+$/
" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Coworkers' Hacks:
imap jj <Esc>

" GoLang
"if exists("g:did_load_filetypes")
"  filetype off
"  filetype plugin indent off
"endif
"set runtimepath+=/usr/local/go/misc/vim
"filetype plugin indent on
"syntax on
