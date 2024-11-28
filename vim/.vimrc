set number relativenumber
set nu rnu
set cursorline
" cursor offset 4 to top and bottom
set scrolloff=7
" use system clipboard
set clipboard=unnamedplus
set clipboard+=unnamed
" windows
set paste

" test

" set tap to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" disable swap files
set noswapfile

" when searching: this adds /g flag by default to search globally
" /foo -> /foo/g
" in VSCode enable vim.gdefault
set gdefault

:hi SpecialKey ctermfg=darkgray guifg=gray70

hi cursorline cterm=none term=none
autocmd winenter * setlocal cursorline
autocmd winleave * setlocal nocursorline
highlight cursorline guibg=#303000 ctermbg=234

let mapleader = " "

" REMAPPINGS
" map: recursive mapping
" noremap: non recursive mapping in normal, visual, selection mode
" nnorremap: NORMAL MODE non recursive mapping
" vnorremap: VISUAL/SELECT MODE non recursive mapping
" xnorremap: VISUAL MODE non recursive mapping
" xnorremap: VISUAL MODE non recursive mapping

nmap <leader>q :q<cr>
nmap <c-s> :w<cr><esc>

" delete into black hole register
" nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
" delete into system register
nnoremap <leader>d "*d
nnoremap <leader>D "*D
vnoremap <leader>d "*d

" press vv to select the whole Line
nnoremap vv v$


" <leader>r search & replace only in visualy selected text
" if text is selected, vim automatically addrs :<','> to commant prompt
" this restricts the search&replace operation to selected text 
vnoremap <leader>r :s/

" <leader>f search only in selected text
" <esc> switch back to normal mode
" /     search
" \%V   only in visual selection
vnoremap <leader>f <esc>/\%V
" STRG-f search 
nnoremap <c-f> /
" STRG-r replace
nnoremap <c-r> :%s/


" STRG-f in visual mode: search for selected text
" "0y   copy selected text to register 0
" /     open search bar
" <c-r>0 paste register 0    
vnoremap <c-f> "0y/<c-r>0
" STRG+r in visual mode: search & replace for selected text
vnoremap <c-r> "0y:%s/<c-r>0//g<left><left>

" CTRL+a select whole document
noremap <c-a> ggVG

" use U redo last undo
noremap U <C-R>


" up and down movements and center screen
noremap J 10j
noremap K 10k

noremap H 10h
noremap L 10l

" switch tabs, switch to normal mode
noremap <C-h> gT
noremap <C-l> gt
noremap <C-j> gT
noremap <C-k> gt


" exit vim
noremap <leader>Q :q!<enter>

noremap <leader>t :tabnew<enter>


noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


nnoremap Q q1
nnoremap q <Nop>
nnoremap @ @1    

" use M to togo marked line
nnoremap M '
nnoremap dm d'
nnoremap <C-m> :marks<enter> "CRTL+m  show all marks

" allow movement in insert mode
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" backspace
nnoremap <BS> "_X
vnoremap <BS> "_X

