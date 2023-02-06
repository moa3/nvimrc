
call plug#begin('/home/moa3/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
" Plug 'Chiel92/vim-autoformat'
Plug 'kovisoft/paredit'
" Plug 'eraserhd/parinfer-rust', {'do':
"         \  'cargo build --release'}
" " Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
" " Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-vividchalk'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind.nvim'
Plug 'lukas-reineke/cmp-rg'

Plug 'liuchengxu/vim-which-key'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'Lokaltog/vim-easymotion'

Plug 'junegunn/vim-emoji'
Plug 'cespare/vim-toml', { 'branch': 'main' }

"  vim-closetag
" Auto close (X)HTML tags
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" Plug 'junegunn/vim-peekaboo'
" Plug 'junegunn/vim-easy-align'
"
" Plug 'sudar/vim-arduino-syntax'
"
" " Requires
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'liquidz/vim-iced', {'for': 'clojure'}

"
Plug 'neovim/nvim-lspconfig'
" Plug 'lspcontainers/lspcontainers.nvim'



Plug 'sirtaj/vim-openscad'

" Initialize plugin system
call plug#end()

let g:node_host_prog = '/usr/bin/neovim-node-host'

" import lua/init.lua
lua require('init')

filetype plugin on
filetype indent on
"
set nocompatible
syntax on

colorscheme vividchalk

" " Use F10 to toggle 'paste' mode
set pastetoggle=<F10>
"
" " Show line, column number, and relative position within a file in the status line
set ruler
"
" " Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3
"
set shiftwidth=2

" " Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" " When a bracket is inserted, briefly jump to a matching one
set showmatch

" " visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <C-e>     :tabedit
map <C-Left>  :tabprevious<CR> " précédent buffer
map <C-Right> :tabnext<CR> " prochain buffer

set et!
set expandtab
set nu!
set smartcase
set ignorecase

nmap <silent> <F7> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2

"Fzf
" set rtp+=~/dev/fzf
" fzf options

nmap <Leader>b :Buffers<CR>
nmap <c-f> :GFiles<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>c :Commits<CR>

let g:python3_host_prog = '/usr/bin/python3'

set completeopt=menu,menuone,noselect


" Go see https://github.com/scrooloose/snipmate-snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<Shift-tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/custom_ultisnips']

set completefunc=emoji#complete
" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

syntax sync minlines=200
syntax sync maxlines=500


" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"

" command! -bang -nargs=* Find
"             \ call fzf#vim#grep(
"             \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
"             \ <bang>0)

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

" Enable vim-iced's default key mapping
" " This is recommended for newbies
" https://liquidz.github.io/vim-iced/
let g:iced_enable_default_key_mappings = v:true
let g:iced_enable_auto_indent = v:true

" https://liquidz.github.io/vim-iced/vim-iced.html#g%3Aiced_formatter
"

let g:iced_formatter = "cljstyle"
let g:sexp_mappings = {'sexp_indent': '', 'sexp_indent_top': ''}
let g:iced_enable_clj_kondo_analysis = v:false
let g:iced_enable_clj_kondo_local_analysis = v:false

" let g:ale_linters = {'clojure': ['clj-kondo']}

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

set listchars=extends:»,precedes:«,nbsp:☠

command! PrettyPrintJSON %!python -m json.tool
command! PrettyPrintHTML !tidy -mi -html -wrap 0 %
command! PrettyPrintXML !tidy -mi -xml -wrap 0 %

set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
nnoremap <Leader>f :grep! "<C-R><C-W>"<CR>:cw<CR><CR>
nnoremap <Leader>F :grep! "<C-R>/"<CR>:cw<CR><CR>

" may not be necessary in the future
command! CloseFloatingWindows lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, false); print('Closing window', win) end end
