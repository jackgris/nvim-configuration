return{
  "joerdav/templ.vim",
  config = function()
  local lspconfig = require 'lspconfig'
  local configs = require 'lspconfig.configs'

  -- start the templ language server for go projects with .templ files
  if not configs.templ then
    configs.templ = {
      default_config = {
        cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/tmp/templ.log" },
        filetypes = { "templ" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        settings = {},
      },
    }
  end
  lspconfig.templ.setup{}

  -- register .templ as a filetype
  vim.filetype.add({ extension = { templ = "templ" } })

  -- HTML and templ filetypes
  lspconfig.html.setup({
    on_attach = function(client, bufnr)
      -- Add your custom on_attach code here
    end,
    capabilities = lspconfig.util.default_config.capabilities,
    filetypes = { "html", "templ" },
  })

  -- htmx configuration
  lspconfig.htmx.setup({
    on_attach = function(client, bufnr)
      -- Add your custom on_attach code here
    end,
    capabilities = lspconfig.util.default_config.capabilities,
    filetypes = { "html", "templ" },
  })

  -- Tailwind CSS setup for templ files
  lspconfig.tailwindcss.setup({
    on_attach = function(client, bufnr)
      -- Add your custom on_attach code here
    end,
    capabilities = lspconfig.util.default_config.capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  })

  -- Emmet setup for auto tag insertion
  lspconfig.emmet_ls.setup({
    on_attach = function(client, bufnr)
      -- Add your custom on_attach code here
    end,
    capabilities = lspconfig.util.default_config.capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  })

  -- Formatting on save for .templ files
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.templ" },
    callback = function()
      local file_name = vim.api.nvim_buf_get_name(0) -- Get file name of file in current buffer
      vim.cmd(":silent !templ fmt " .. file_name)

      local bufnr = vim.api.nvim_get_current_buf()
      if vim.api.nvim_get_current_buf() == bufnr then
        vim.cmd('e!')
      end
    end
  })
end
}
