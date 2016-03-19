""""""""""""""""""""""""
"  Vundle and Plugins  "
""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'vim-scripts/vim-svngutter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'chriskempson/base16-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'jamessan/vim-gnupg'
Plugin 'aklt/plantuml-syntax'
Plugin 'junegunn/fzf.vim'

" Ultisnips and dependencies
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'

" Snippets are separated from the engine. Type :UltiSnipsAddFiletypes <language>
" to add snippets for a given language.
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" FZF
" Enable fzf search
set rtp+=~/.fzf


""""""""""""""""""""""
"       Config       "
""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Oxeded colourscheme from https://github.com/queyenth/oxeded.vim
" Install by copying .vim colour file into ~/.vim/colors
colorscheme oxeded
let base16colorspace=256

" Use spaces instead of tabs
set expandtab
set nonumber
set smarttab

" tty is fast, send more characters at a time, improving responsivenes
set ttyfast

" Preserve (hide) buffer when exiting a file
set hidden

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Prevents some security exploits
set modelines=0

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 80 characters
set lbr
set tw=80
set formatoptions=qrn1

" Highlight area to the right of 80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Show invisible characters like spaces
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<

set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Always show the status line
set laststatus=2

" Default file types
set ffs=unix,mac,dos

" Set to auto read when a file is changed from the outside
set autoread

" Make help open in new tab
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

" Do not search here
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/node_modules/*

"""""""""""""""
"  Syntastic  "
"""""""""""""""
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = []
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{fugitive#statusline()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""
"  GPG  "
"""""""""
let g:GPGExecutable = "gpg2"
let g:GPGPreferArmor = 1
let g:GPGPreferSign = 1
let g:GPGDefaultRecipients = "0E25CFCC"

"""""""""""""""
"  UltiSnips  "
"""""""""""""""
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Where does the window to edit snippets open?
let g:UltiSnipsEditSplit="vertical"


""""""""""""""""""
"  Key bindings  "
""""""""""""""""""

" The best hotkey ever
map <c-up> 10k
map <c-down> 10j
map <c-j> 10j
map <c-k> 10k

" Navigate sideways, useful when set nowrap
map <c-right> z10l
map <c-left> z10h
map <c-h> 10h
map <c-l> 10l

" NERDTree
map <c-n> :NERDTreeToggle<CR>

" FZF search git files on C-p
" This ignores stuff like node_modules
map <c-p> :GitFiles<CR>

" Quote: get rid of that stupid goddamned help key that you will invaribly hit
" constantly while aiming for escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


""""""""""""
"  Leader  "
""""""""""""

" Reassign leader to space
let mapleader = "\<Space>"

" Leader shortcuts
" Quickly save current file
nnoremap <Leader>w :w<CR>


"""""""""""""""
"  Functions  "
"""""""""""""""

" Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS() " Execute whenever anything is written

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


""""""""""""
"  NeoVIM  "
""""""""""""

if has('nvim')
  " Get out of terminal mode with Esc
  tnoremap <Esc> <C-\><C-n>
endif

