return {
  colorscheme = "catppuccin-macchiato",
  options = {
    opt = {
      colorcolumn = "80,120",
      list = true,
      listchars = "trail:.",
      foldenable = false,
      foldmethod = "manual",
      foldlevel = 99,
    },
  },
  lsp = {
    mappings = {
      n = {
        -- this mapping will only be set in buffers with an LSP attached
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
    },
    servers = {
      ---- Frontend & NodeJS
      "tsserver",      -- typescript/javascript language server
      "tailwindcss",   -- tailwindcss language server
      "html",          -- html language server
      "cssls",         -- css language server
      ---- Configuration Language
      "marksman",      -- markdown ls
      "jsonls",        -- json language server
      "yamlls",        -- yaml language server
      "taplo",         -- toml language server
      ---- Backend
      "lua_ls",        -- lua
      "rust_analyzer", -- rust
      "pyright",       -- python
      "ruff_lsp",      -- extremely fast Python linter and code transformation
      "jdtls",         -- java
      "nil_ls",        -- nix language server
      ---- Operation & Cloud Nativautoindente
      "bashls",        -- bash
      "cmake",         -- cmake language server
      "clangd",        -- c/c++
      "dockerls",      -- dockerfile
      "jsonnet_ls",    -- jsonnet language server
      "terraformls",   -- terraform hcl
    },
    setup_handlers = {
      -- add custom handler
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end
    },
    formatting = {
      format_on_save = false,
    },
    config = {
      metals = {
        find_root_dir_max_project_nesting = 2,
      },
    },
    plugins = {
      "simrat39/rust-tools.nvim", -- add lsp plugin
    },
  },
}
