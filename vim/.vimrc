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
" noremap <leader>r "0y:%s/<c-r>0//g<left><left>

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

" switch tabs
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <C-j> gT
nnoremap <C-k> gt


" exit vim
noremap <leader>Q :q!<enter>

noremap <leader>t :tabnew<enter>