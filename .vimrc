inoremap kj <Esc>
inoremap KJ <Esc>
inoremap /* /**/<left><left>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-h> :NERDTree<CR>
nnoremap m :NERDTreeFocus<CR>

set number
set relativenumber
set autoindent

syntax on
colorscheme codedark
hi LineNr ctermfg=grey ctermbg=NONE
hi Normal ctermbg=NONE
hi EndOfBuffer ctermbg=NONE



call plug#begin()

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'

call plug#end()
