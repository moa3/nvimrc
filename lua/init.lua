

-- LSP config
-- Taken from https://github.com/neovim/nvim-lspconfig/#Suggested-configuration

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local merge_conf = function(my_conf)
  -- Sensible defaults
  local default_conf = {
    before_init = function(params)
      params.processId = vim.NIL
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    -- Try and launch the lsp server from a .lsp_runner executable file in the
    -- root dir of the project. Useful if the LSP server lives in a container.
    -- Exemple .lsp_runner file:
    --
    -- #!/usr/bin/env bash

    -- exec docker-compose exec -i <my_lsp_container> <lsp-binary> "$@"
    on_new_config= function (new_config, new_root_dir)
      local bin = lspconfig.util.path.join(new_root_dir, '.lsp_runner')
      if lspconfig.util.path.is_file(bin) then
        new_config.cmd = { bin }
      else
        require('vim.lsp.log').warn(string.format(
        '%s file was not found in root dir. Using default cmd if available',
        bin))
      end
    end,
    root_dir = lspconfig.util.root_pattern(".git")
  }

  for key,value in pairs(my_conf) do
    default_conf[key] = value
  end
  return default_conf
end

lspconfig.clojure_lsp.setup(
merge_conf({
  cmd = { 'clojure-lsp' },
  filetypes = { "clojure", "edn" },
  root_dir = lspconfig.util.root_pattern("project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git")
}))

lspconfig.solargraph.setup(
merge_conf({
  cmd = { 'solargraph' },
  filetypes = { "ruby" },
  init_options = { formatting = true },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}))

-- nvim-cmp

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'nvim_lua' },
    { name = 'emoji' },
    -- { name = 'rg' },
  }, {
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        ultisnips = "[Snip]",
        nvim_lua = "[Lua]",
      })
    }),
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
