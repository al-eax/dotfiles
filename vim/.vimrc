set number relativenumber
set nu rnu
set cursorline
" cursor offset 4 to top and bottom
set scrolloff=9999
" use system clipboard
set clipboard=unnamedplus
set clipboard+=unnamed
" windows
set paste

" set tap to 4 spaces
set ts=4 sw=4


hi cursorline cterm=none term=none
autocmd winenter * setlocal cursorline
autocmd winleave * setlocal nocursorline
highlight cursorline guibg=#303000 ctermbg=234

let mapleader = " "

nmap <leader>q :q<cr>
nmap <c-s> :w<cr><esc>

" paste text and dont store deleted text in register (clipboard)
" "_    black hohle register
" d     delete selection
" p     paste selection
xnoremap p "_dp
" deleted text will not be stored in register (clipboard)
noremap d "_d
noremap dd "_dd

" <leader>r search&replace the visualy selected text
"   "0y       yank selected text to register 0
"   :       enter command
"   %s/     search
"   <c-r>0  paste content register 0 to search for 
"   /       let user insert text replacement
"   /g      search and replace globally
"   <left>  move cursor left to let user insert replacement
noremap <leader>r "0y:%s/<c-r>0//g<left><left>

" <leader>vr search & replace only in visualy selected text
"   :s/     search
"   \%v     only in visualy selected text
"           let user insert text to search
"           let user insert text to replace
"   /g      search globally
"   <left>  cursor left to let user insert search/replacement
vnoremap <leader>vr :s/\%v<left><ljeft>

" STRG-f search 
noremap <c-f> /
" STRG-r replace
noremap <c-r> :%s/

" CTRL+a select whole document
noremap <c-a> ggVG

" use U redo last undo
noremap U <C-R>


" up and down movements and center screen
nnoremap J 10j
nnoremap K 10k

nnoremap H 10h
nnoremap L 10l

" switch tabs
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <C-j> gT
nnoremap <C-k> gt


" exit vim
noremap <leader>Q :q!<enter>

noremap <leader>t :tabnew<enter>