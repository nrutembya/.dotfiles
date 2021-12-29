let mapleader = "'"
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>l :q!<cr>
nmap <leader>; :wq<cr>
:imap <C-L> <Esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><space> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>d :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>a :bufdo bd<cr>

" Exit vim
map <C-x> :bufdo bd<cr>:q!<cr>

" Useful mappings for managing tabs
map <C-t> :tabnew<cr>
map <C-n> :tabnext<cr>
map <C-c> :tabclose<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set laststatus=2

syntax on
filetype plugin indent on

set nobackup
set nowb
set noswapfile

set background=light
set number
set hlsearch
set ignorecase
set incsearch
set mouse=a
set shiftwidth=2
set expandtab
set smartindent
set smarttab
set softtabstop=2
set wildmenu
set wildmode=longest:full,full
set ruler
set encoding=UTF-8

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'jiangmiao/auto-pairs'
  Plug 'elixir-editors/vim-elixir'
  Plug 'tpope/vim-commentary'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()


" Nerdtree configuration

let NERDTreeShowHidden=1                  " Show hidden files
let NERDTreeAutoDeleteBuffer = 1          " Delete buffer after nerdtree file deletion
au VimEnter *  NERDTree                   " Open Nerdtree automatically
let NERDTreeQuitOnOpen = 1                " Quit Nerdtree automatically
let NERDTreeMinimalUI = 1                 " Prettier UI (remove '?' message)
let NERDTreeDirArrows = 1                 " Prettier directory arroow
let g:NERDTreeGitStatusUseNerdFonts = 1   " Show git status
let g:NERDTreeGitStatusShowIgnored = 1    " Show ignored status

" Open & edit file in Nerdtree
nnoremap <Leader>f :NERDTreeToggle<Enter> 
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
