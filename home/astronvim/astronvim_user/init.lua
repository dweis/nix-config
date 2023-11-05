return {
  colorscheme = "catppuccin-macchiato",
  options = {
    opt = {
      colorcolumn = "80,120",
      list = true,
      listchars = "trail:.",
    },
  },
  lsp = {
    mappings = {
      n = {
        -- this mapping will only be set in buffers with an LSP attached
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
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
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "rust_analyzer" },
        },
      },
    },
  },
}
