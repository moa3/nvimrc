
call plug#begin('/home/moa3/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
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
Plug 'dense-analysis/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'fszymanski/deoplete-emoji'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
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
" Plug 'clojure-vim/async-clj-omni'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'liquidz/vim-iced-asyncomplete', {'for': 'clojure'}

"
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'sirtaj/vim-openscad'

" Initialize plugin system
call plug#end()

let g:node_host_prog = '/usr/bin/neovim-node-host'


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
" " Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" " When a bracket is inserted, briefly jump to a matching one
set showmatch

" " visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <C-e>  :tabedit
map <C-Left>  :tabprevious<CR>" précédent buffer
map <C-Right> :tabnext<CR>" prochain buffer

set et!
set expandtab
set nu!
set smartcase
set ignorecase

nmap <silent> <F7> :NERDTreeToggle<CR>

"Fzf
set rtp+=~/dev/fzf
" fzf options

nmap <Leader>b :Buffers<CR>
nmap <c-f> :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>c :Commits<CR>

lua << EOF
local lsp_installer = require("nvim-lsp-installer")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

end

local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        },
                        },
                        }
                        }

    -- config that activates keymaps and enables snippet support
    local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
        }
    end

    -- Include the servers you want to have installed by default below
    local servers = {
    "bashls",
    "yamlls",
    "tailwindcss",
    "lua",
    "clangd",
    "sourcekit"
    }

    for _, name in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found then
            if not server:is_installed() then
                print("Installing " .. name)
                server:install()

            end
        end
    end

    -- Register a handler that will be called for all installed servers.
    -- Alternatively, you may also register handlers on specific server instances instead (see example below).
    lsp_installer.on_server_ready(function(server)

    local config = make_config()

    -- language specific config
    if server.name == "lua" then
        config.settings = lua_settings
    end
    if server.name == "tailwindcss" then
        config.filetypes = {"eruby", "html", "css", "scss"};
    end

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     config.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(config)
    end)

EOF

" lua << EOF
" local nvim_lsp = require('lspconfig')


" -- Use a loop to conveniently call 'setup' on multiple servers and
" -- map buffer local keybindings when the language server attaches
" -- local servers = { "solargraph" }
" -- for _, lsp in ipairs(servers) do
" --   nvim_lsp[lsp].setup {
" -- 	on_attach = on_attach,
" -- 	flags = {
" -- 	  debounce_text_changes = 150,
" -- 	}
" --   }
" -- end

" nvim_lsp.solargraph.setup{
" -- cmd { "solargraph", "stdio" }
"   cmd = {"docker-compose", "run", "--rm", "platform", "bundle", "exec", "solargraph", "stdio"},
"   on_attach = on_attach,
"   flags = {
" 	  debounce_text_changes = 150,
" 	  },
"   settings = {
"     solargraph = {
"       diagnostics = true,
"       completion = true
"     }
"   }
" }

" -- Configure lua language server for neovim development
" local lua_settings = {
"   Lua = {
"     runtime = {
"       -- LuaJIT in the case of Neovim
"       version = 'LuaJIT',
"       path = vim.split(package.path, ';'),
"     },
"     diagnostics = {
"       -- Get the language server to recognize the `vim` global
"       globals = {'vim'},
"     },
"     workspace = {
"       -- Make the server aware of Neovim runtime files
"       library = {
"         [vim.fn.expand('$VIMRUNTIME/lua')] = true,
"         [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
"       },
"     },
"   }
" }

" -- config that activates keymaps and enables snippet support
" local function make_config()
"   local capabilities = vim.lsp.protocol.make_client_capabilities()
"   capabilities.textDocument.completion.completionItem.snippetSupport = true
"   return {
"     -- enable snippet support
"     capabilities = capabilities,
"     -- map buffer local keybindings when the language server attaches
"     on_attach = on_attach,
"   }
" end

" -- lsp-install
" local function setup_servers()
"   require'lspinstall'.setup()

"   -- Set log level to debug
"   -- vim.lsp.set_log_level(1)

"   -- get all installed servers
"   local servers = require'lspinstall'.installed_servers()
"   -- ... and add manually installed servers
"   table.insert(servers, "clangd")
"   table.insert(servers, "sourcekit")

"   for _, server in pairs(servers) do
"     local config = make_config()

"     -- language specific config
"     if server == "lua" then
"       config.settings = lua_settings
"     end
"     if server == "tailwindcss" then
"       config.filetypes = {"eruby", "html", "css", "scss"};
"     end

"     require'lspconfig'[server].setup(config)
"   end
" end

" setup_servers()

" -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
" require'lspinstall'.post_install_hook = function ()
"   setup_servers() -- reload installed servers
"   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
" end

" EOF

let g:python3_host_prog = '/usr/bin/python3'

let g:deoplete#enable_at_startup = 1
" let g:deoplete#max_abbr_width = 0
" let g:deoplete#max_menu_width = 0
" let g:deoplete#omni#input_patterns = get(g:,’deoplete#omni#input_patterns’,{})
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option({
			\ 'camel_case': v:true,
			\ 'refresh_always': v:true,
			\ 'auto_refresh_delay': 40,
			\ 'ignore_case': v:true,
			\ 'smart_case': v:true,
			\})


" Go see https://github.com/scrooloose/snipmate-snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<Shift-tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/custom_ultisnips']

set completefunc=emoji#complete
" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

syntax sync minlines=200
syntax sync maxlines=500

call deoplete#custom#source('emoji', 'converters', ['converter_emoji'])

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

command! -bang -nargs=* Find
            \ call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
            \ <bang>0)

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

" set grepprg=ag\ --nogroup
"
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
nnoremap <Leader>f :grep! "<C-R><C-W>"<CR>:cw<CR><CR>
nnoremap <Leader>F :grep! "<C-R>/"<CR>:cw<CR><CR>

command! CloseFloatingWindows lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, false); print('Closing window', win) end end
