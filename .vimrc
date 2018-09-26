"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-system-copy'
Plugin 'Yggdroot/indentLine'
"Plugin 'chrisbra/csv.vim'
Plugin 'jistr/vim-nerdtree-tabs'

call vundle#end()
filetype plugin indent on

runtime ftplugin/man.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Sudo fast saving
nmap <leader>sw :w !sudo tee % >/dev/null<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Max opened tabs when do you `vim -p`
set tabpagemax=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
set t_Co=256

colorscheme desert
if $USER == 'root'
    set background=light
    set background=dark " not the same dark after light toggled =)
else
    set background=dark
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
	set guifont=Gohu\ GohuFont\ 10
	highlight Cursor guifg=white guibg=green
	autocmd GUIEnter * set vb t_vb=
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
" set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>ts :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*<left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<home><C-right><C-right><left>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
" map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" *******************************************************************************************************
set number
" ctrl+u to uppercase current word - useful for C constants
inoremap <c-u> <esc>viwU<esc>ei
" Fast quit
nmap <leader>q :q<cr>
nmap <leader>q1 :q!<cr>
nmap <leader>aq :qa<cr>

" From CamelCase to lower_case
nmap <leader>ctl :s/\<\u\\|\l\u/\=len(submatch(0)) == 1 ? tolower(submatch(0)) : submatch(0)[0].'_'.tolower(submatch(0)[1])/g<cr>

"Move tabs right/left on one position
nmap <leader>tr :tabm +1<cr>
nmap <leader>tl :tabm -1<cr>

nmap <leader>ne :set number<cr>
nmap <leader>nd :set nonumber<cr>

"Sessions write/restore
nmap <F2> :mksession! ~/.vim/vim_session<cr>
nmap <F3> :source ~/.vim/vim_session<cr>

"nmap nse syntax terminal
au BufRead,BufNewFile *.nse set filetype=nse
au! Syntax nse source /usr/share/vim/vim74/syntax/lua.vim

"Pop up Tagbar
nnoremap <silent><leader>b :TagbarToggle<cr>

""" Show Tabs numbers
set tabline=%!MyTabLine()
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
	" select the highlighting
	if i + 1 == tabpagenr()
	  let s .= '%#TabLineSel#'
	else
	  let s .= '%#TabLine#'
	endif

	" set the tab page number (for mouse clicks)
	let s .= '%' . (i + 1) . 'T'

	" the label is made by MyTabLabel()
	let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
	let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return '[' . buflist[winnr - 1] . ']' . bufname(buflist[winnr - 1])
endfunction

" ****** Files explorer ******
" use NERD Tree
"noremap <leader>e :NERDTreeCWD<cr>
noremap <leader>e :NERDTreeTabsToggle<cr>
let NERDTreeShowHidden=1
" open nerdtree on newtab
"autocmd BufWinEnter * NERDTreeMirror
" use default netrw
" nmap <leader>e :Explore<cr>

" Fuzzy Finder
noremap <leader>f :Files<cr>

" YouCompleteMe popup menu's colors
highlight Pmenu guifg=#ffffff guibg=#008700
let g:ycm_show_diagnostics_ui = 0
let g:ycm_python_binary_path = 'python'
" use ycm goto declaration for python
autocmd FileType python map <buffer> <C-LeftMouse> :YcmCompleter GoToDeclaration<cr>
autocmd FileType python nnoremap <buffer> <C-RightMouse> <C-O>

" vim-rtags 
let g:rtagsUseDefaultMappings = 0
let g:rtagsRcCmd = "rtags"
let g:rtagsAutoLaunchRdm = 1
noremap <C-\>g :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <C-LeftMouse> :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <C-\>d :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
noremap <C-@>g :call rtags#JumpTo(g:NEW_TAB)<CR>
noremap <C-\>s :call rtags#FindRefs()<CR>
noremap <C-r> :call rtags#JumpBack()<CR>
noremap <C-RightMouse> :call rtags#JumpBack()<CR>
" close LocationList when file gets selected
" autocmd FileType LocationList nmap <buffer> <cr> <cr>:lcl<cr>

" vim-system-copy
let g:system_copy#copy_command='xclip -selection clipboard -in'
let g:system_copy#paste_command='xclip -selection clipboard -out'

" IndentLine
" Use indentLine plugin if we use spaces
let g:indentLine_char = '.'
let g:indentLine_color_term = 239
"Display indentation dots if we use tabs ¦
set list lcs=tab:\,\ 
hi SpecialKey guifg=grey30 ctermfg=grey

" Location list (quickfix) - open in a new tab
" set switchbuf+=usetab,newtab

" Man pages
function ManRead(section)
	let wordUnderCursor = expand("<cword>")
	execute ":Man " . a:section . " " . wordUnderCursor
	execute ":20winc +"
endfunction
" General Linux / bash pages
noremap 1<LeftMouse> :call ManRead(1)<cr>
noremap 1<RightMouse> :q<cr>
" Linux C stdlib pages
noremap 3<LeftMouse> :call ManRead(3)<cr>
noremap 3<RightMouse> :q<cr>
" Misc pages
noremap 7<LeftMouse> :call ManRead(7)<cr>
noremap 7<RightMouse> :q<cr>

" ***** Move between tabs with mouse  ***
noremap <S-LeftMouse> :tabp<cr>
noremap <S-RightMouse> :tabn<cr>

