let mapleader = "'"

nnoremap <Leader>[ :Autoformat<CR>
nmap <leader>; :w<cr>
nmap <leader>l :q!<cr>
nmap <leader>;l ZZ
imap <C-q> <Esc>

function! SaveOrQuit()
    if &modified
        write
    else
        quit
    endif
endfunction

nmap <C-q> :call SaveOrQuit()<cr>
nmap <C-e> :q<cr>
nmap <leader>. $
nmap <leader>, 0
vnoremap <C-y> "+y
vnoremap <C-x> "+x
nmap <C-p> "+p
vmap <C-p> x"+p
imap <C-p> <C-r>*
imap <C-a> <ESC>ggVG
nmap <C-a> ggVG
imap <C-v> <ESC>v
nmap <C-v> v
nnoremap <Leader>\ 0i<BS><cr><Esc>j
nnoremap <space> i<space>
nnoremap <BS> <ESC>
nnoremap <Leader><Leader> i

" Moving around, tabs, windows, and buffers

" Disable highlight when <leader><cr> is pressed
nnoremap <leader>/ :nohlsearch<CR>

" Smart way to move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Close the current buffer
" nnoremap <leader>d :Bclose<CR>:tabclose<CR>gT

" Close all buffers
" nnoremap <leader>a :bufdo bd<CR>

" Exit Vim
nnoremap <leader><cr> :bufdo bd<cr>:q!<cr>

" Useful mappings for managing tabs
nnoremap <C-t> :tabnew<cr>
nnoremap <C-n> :tabnext<cr>
nnoremap <C-c> :tabclose<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/<cr>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

syntax on
filetype plugin indent on

set nobackup
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
set nocompatible

" Configure column cursor
autocmd InsertEnter * set cursorcolumn
autocmd InsertLeave * set nocursorcolumn
highlight CursorColumn ctermfg=white ctermbg=25

" Configure line cursor 
highlight CursorLine ctermfg=white ctermbg=25

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

call plug#begin(data_dir . '/plugged')
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' 
if has('nvim')
  Plug 'kevinhwang91/rnvimr'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
else
  Plug 'francoiscabrol/ranger.vim'
endif
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'pseewald/vim-anyfold'
Plug 'haya14busa/is.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'preservim/tagbar'
Plug 'romainl/vim-qf'
Plug 'junegunn/gv.vim'
Plug 'jreybert/vimagit'
call plug#end()

" GV configuration
nnoremap <leader>gg :GV --all<cr>

" Magit configuration
nnoremap <leader>m :Magit<cr>
nnoremap <leader>mm :Magit<cr><c-q>:Magit<cr>

" Tagbar configuration
nnoremap <f8> :TagbarToggle<cr>
let g:tagbar_ctags_bin = '/opt/local/bin/ctags'
let g:tagbar_type_elixir = {
    \ 'ctagstype': 'elixir',
    \ 'kinds': [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
\ }
hi tagbarhighlight ctermfg=white ctermbg=25

" Rainbow configuration
au FileType elixir,typescript,bash,vim,json,javascript,html,css call rainbow#load()
let g:rainbow_guifgs = ['royalblue3', 'darkorange3', 'darkorchid3', 'firebrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" Telescope configuration
nnoremap <c-g> <cmd>Telescope find_files<cr>
imap <c-g> <esc><cmd>Telescope find_files<cr>
nnoremap <c-s> <cmd>Telescope current_buffer_fuzzy_find<cr>
imap <c-s> <esc><cmd>Telescope current_buffer_fuzzy_find<cr>
vnoremap <c-s> "+y<cmd>Telescope current_buffer_fuzzy_find<cr>
imap <c-s> <esc>"+y<cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <c-f> <cmd>Telescope live_grep<cr>
imap <c-f> <esc><cmd>Telescope live_grep<cr>
vnoremap <c-f> "+y<cmd>Telescope live_grep<cr>
imap <c-f> <esc>"+y<cmd>Telescope live_grep<cr>
nnoremap <c-z> <cmd>Telescope buffers<cr>
imap <c-z> <esc><cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
imap <leader>fh <esc><cmd>Telescope help_tags<cr>

hi telescope_selection ctermfg=white ctermbg=25
hi telescope_preview_line ctermfg=white ctermbg=25
hi quickfixline ctermfg=white ctermbg=25

" Open quickfix in vertical split
autocmd FileType qf wincmd l
set switchbuf+=uselast

" Change highlight colors for git integration
highlight DiffChange ctermfg=none ctermbg=31
highlight DiffAdd ctermfg=none ctermbg=34
highlight DiffDelete ctermfg=none ctermbg=196

" Ranger configuration
if has('nvim')
  let g:rnvimr_enable_picker = 1
  let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
  let g:rnvimr_enable_bw = 1
  let g:rnvimr_presets = [
        \ {'width': 0.600, 'height': 0.600},
        \ {},
        \ {'width': 0.800, 'height': 0.800},
        \ {'width': 0.950, 'height': 0.950},
        \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
        \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
        \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
        \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
        \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
        \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
        \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
        \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
        \ ]
  tnoremap <silent> <c-r> <c-><c-n>:RnvimrResize<cr>
  nnoremap <silent> <c-d> :RnvimrToggle<cr>
  tnoremap <silent> <c-d> <c-><c-n>:RnvimrToggle<cr>
else
  let g:nerdtree_hijack_netrw = 0
  let g:ranger_replace_netrw = 1
  let g:ranger_map_keys = 0
  map <c-d> :Ranger<cr>
endif
        
" NERDTree configuration
let NERDTreeShowHidden = 1 " Show hidden files
let NERDTreeAutoDeleteBuffer = 1 " Delete buffer after NERDTree file deletion
let NERDTreeMinimalUI = 1 " Prettier UI (remove '?' message)
let NERDTreeDirArrows = 1 " Prettier directory arrow
let g:NERDTreeGitStatusUseNerdFonts = 1 " Show git status
let g:NERDTreeGitStatusShowIgnored = 1 " Show ignored status

""" open & edit file in nerdtree
" check if nerdtree is open or active
function! IsNerdTreeOpen()        
  return exists("t:nerdtreebufname") && (bufwinnr(t:nerdtreebufname) != -1)
endfunction

function! OpenTree()
  if !IsNerdTreeOpen()
    NerdTree
  endif
endfunction

function! SyncTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NerdTreeFind
    wincmd p
  else
    :call OpenTree()
  endif
endfunction

nnoremap <silent> <leader>d :call SyncTree()<cr>

" highlight currently open buffer in nerdtree
" autocmd bufenter * call synctree()
" autocmd vimenter * call synctree()
" autocmd vimenter * call opentree()
" automatically quit vim if nerdtree is last and only buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree()) | q | endif
