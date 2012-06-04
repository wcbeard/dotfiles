"help from http://amix.dk/blog/post/160
" space, tab in normal mode

let os = substitute(system('uname'), "\n", "", "")
autocmd VimEnter * echo "Ready to work on" os

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

au FileType python set omnifunc=pythoncomplete#Complete
filetype plugin indent on
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" Set font according to system
"if MySys() == "mac"
if os == "Darwin"
	set gfn=Menlo:h16
	set shell=/bin/bash
	"set transparency=10 "placed in /Applications/MacVim.app/Contents/Resources/vim/gvimrc
	"set invmmta "placed in /Applications/MacVim.app/Contents/Resources/vim/gvimrc
	" nnoremap ,m :tabnew ~/.vim/plugin/vimacs-0.95.vim<CR>
	"colorscheme inkpot "placed in /Applications/MacVim.app/Contents/Resources/vim/gvimrc
	let g:miniBufExplMapWindowNavVim = 1 
	let g:miniBufExplMapWindowNavArrows = 1 
	let g:miniBufExplMapCTabSwitchBufs = 1 
	let g:miniBufExplModSelTarget = 1 
	let g:SuperTabDefaultCompletionType = "context"

elseif MySys() == "linux"
	colorscheme ir_black

elseif MySys() == "windows"
	set langmenu=en_US.UTF-8
	filetype plugin on
	set gfn=DejaVu_Sans_Mono:h14 "needs to be backslashed? maybe not
	set clipboard=unnamed
	colorscheme inkpot
endif


"nnoremap ,v :tabnew $MYVIMRC<CR>
nnoremap ,v :tabnew ~/vimrc.vim<CR>
set clipboard=unnamed
nnoremap ,lk :NERDTree<CR>
nnoremap ,nt :NERDTree<CR>
nnoremap ,m :MRU<CR>


if has('gui_running')
    set guioptions-=T   " Get rid of toolbar "
    set guioptions-=m   " Get rid of menu    "
endif

"=========C-p,n Fx========
"Function to toggle whether C-p,n control movements or tab complete in insert mode
" help on variables from here http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
let ttovar=1

fun! Tabnp()
	if g:ttovar==1
		inoremap <C-p> <C-p>
		inoremap <C-n> <C-n>
		" let g:SuperTabMappingForward = '<c-n>'
		" let g:SuperTabMappingBackward = '<c-p>'
		let g:ttovar=0
	elseif g:ttovar==0
		inoremap <C-p> <C-o>gk
		inoremap <C-n> <C-o>gj
	let g:ttovar=1
endif
endfun

" inoremap <C-p> <C-p>
" inoremap <C-n> <C-n>
nnoremap ,t :call Tabnp()<CR>
nmap <space> zz
nmap n nzz
nmap N Nzz

" Code folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
" set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Omnicomplete, from http://vim.wikia.com/wiki/Omni_completion
filetype plugin on
set ofu=syntaxcomplete#Complete

fun! Tabnp()
      inoremap <C-p> <C-p>
      inoremap <C-n> <C-n>
endfun
" noremap <Tab>e :call TabVimacs()<cr>
" noremap <Tab>p :call Tabnp()<cr>

" fun! TabVimacs()
"       inoremap <C-p> <C-o>gk
"       inoremap <C-n> <C-o>gj
" endfun
 
 imap jj <Esc>
 set keymap=dvorak 
 set nocompatible
 "inoremap <S-Tab> <C-o>j
 set backspace=eol,start,indent
 
" =====Tab and Line Management=====
"settings from http://amix.dk/vim/vimrc.html
"set expandtab   "uses spaces instead of tabs in ins mod
set shiftwidth=4
 "number of spaces for autoindent
set tabstop=4
"set smarttab
set wrap "Wrap lines
set lbr
syn on
set nolist  " list disables linebreak
set tw=500
set si "Smart indent 
set wildmode=longest:full "tab-complete does longest instead of 1st
set wildmenu
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set autochdir
"========decrease/increase tabstop=======
" http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
nmap <silent> ]] :let &tabstop += 1 \| let &shiftwidth +=1<CR>
nmap <silent> [[ :let &tabstop -= &tabstop > 1 ? 1 : 0 \| let &shiftwidth -= &shiftwidth > 1 ? 1 : 0<CR>

"=======resize windows with +,-======
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

"" This sometimes messes stuff up...
"nnoremap <D-]> <C-W>w
"nnoremap <D-[> <C-W>W

"========Insert time and date====
" http://tobym.posterous.com/vim-insert-date-and-time-directly
iab <expr> ddate strftime("%c")
iab <expr> ttime strftime("%H:%M")
iab <expr> ptime strftime("%l:%M %p")

"=======Converting to visual line========
nnoremap 0 g0
nnoremap g0 0
nnoremap ^ g^
nnoremap g^ ^
nnoremap $ g$
nnoremap g$ $
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
noremap <S-Enter> O<Esc>
noremap <CR> o<Esc>
  
nnoremap - g$
" get rid of Google docs weird newline
" nnoremap <Leader>k :%s//\r/g

	 " C-j should insert new line in normal mode (this slick solution doesn't do it at the point, but moves whole line down one) --from http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
"nnoremap <C-J> ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>
    " C-M and C-J are going to be same as rest of UNIX, but C-m maintains its position
nnoremap <C-M> i<CR><Esc>0k$
nnoremap <C-J> i<CR><Esc>
nnoremap ,b :ls<CR>:buffer<Space>
nnoremap ,r :reg<CR>
nnoremap ,f :MRU<CR>
	" open line below, above current position
nnoremap ,n m`jdd``
nnoremap ,p m`kdd``
nnoremap ,N m`o<Esc>``
nnoremap ,P m`O<Esc>``
nnoremap <C-p> m`O<Esc>``
nnoremap <C-n> m`o<Esc>``
	" emacs open line below:
nnoremap <C-o> m`<CR><Esc>``
"nnoremap <C-S-p> m`kdd``
"nnoremap <C-S-n> m`jdd``
    " make 'Y' yank command consistent
nnoremap Y v$y

"Close a buffer the way it should be closed
nnoremap <C-x>k :w<CR>:bw<CR>
nnoremap ,<CR> :w<CR>:bw<CR>

"searching: incremental, highlight all, and ignore case
set incsearch		" do incremental searching
set ignorecase
set smartcase
set complete=.,w,b,u,U,t,i,d	" do lots of scanning on tab completion
set ttyfast                   	" we have a fast terminal	
" set guioptions-=e	" Turn off tabs
"set hlsearch " why doesn't this turn itself off???
set showcmd

set nohidden  "kill buffer on tab close
set number

" Backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"C-r redo
	". repeat
	" C-f,b move screen forward, back
	" http://jmcpherson.org/editing.html
	" * move to next repeated word
	"# previous occurence
	"`. last edited line
	"ma bookmark a
	"`a go to bookmark a
	"I insert mode @ beginning of line
	"A eol
	":reg - to list register contents
	""ky yank to register k (..p to paste from)
	" c-w gf: file under cursor
" http://aymanh.com/a-collection-of-vim-tips
  " good tips like window, buffer management
  " zr, zm for folding


"Buffers
"http://tnerual.eriogerg.free.fr/vimqrc.html
"http://vim.wikia.com/wiki/VimTip686
"http://vim.wikia.com/wiki/Vim_buffer_FAQ


" kill ring plugin http://www.vim.org/scripts/script.php?script_id=1234
  " view register contents- :reg
"git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
"git add .
"git commit -m "Install Fugitive.vim bundle as a submodule."
"screen -R
"  Reattach to a previously detatched session
"  Ctrl-a c
"  Create a new window.
"  Ctrl-a k
"  Kill the current window - after confirmation
"  Ctrl-a Ctrl-a
"  Switch to the other window
"  Ctrl-a S
"  Split the current window in two.
"  Ctrl-a TAB
"  Move between split sections of the screen.
