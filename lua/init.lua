

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

require'lspconfig'.clojure_lsp.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "clojure-lsp" },
  -- cmd = { "cd /home/moa3/praditus/otus && docker-compose exec -i otus clojure-lsp" },
  filetypes = { "clojure", "edn" },
  root_dir = require'lspconfig/util'.root_pattern("project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git")
}

-- local clojure_lsp_cmd = function (runtime, workdir, image, network, docker_volume)
--   local mnt_volume
--   if docker_volume ~= nil then
--     mnt_volume ="--volume="..docker_volume..":"..workdir..":z"
--   else
--     mnt_volume = "--volume="..workdir..":"..workdir..":z"
--   end

--   return {
--     runtime,
--     "exec",
--     "-it",
--     image,
--     "clojure-lsp"
--   }

-- end



-- require'lspconfig'.clojure_lsp.setup{
--   on_attach = on_attach,
--   -- capabilities = capabilities,
--   cmd = require'lspcontainers'.command('clojure-lsp', {
--     image = "otus",
--     container_runtime = "docker-compose",
--     cmd_builder = clojure_lsp_cmd,

--     -- cmd = function (runtime, volume, image)
--     --   return {
--     --     "docker-compose",
--     --     "exec",
--     --     "-i",
--     --     "otus",
--     --   }
--     -- end,
--   }),
--   -- root_dir = require'lspconfig/util'.root_pattern(".git", vim.fn.getcwd()),
-- }

-- LSP config end

