return {
  -- Colorschemes
  { "altercation/vim-colors-solarized" },
  { "morhetz/gruvbox" },
  { "tomasr/molokai" },

  -- Editing
  { "tpope/vim-surround" },
  { "easymotion/vim-easymotion" },
  {
      "XXiaoA/atone.nvim",
      cmd = "Atone",
      opts = {},
  },

  -- Git
  { "airblade/vim-gitgutter" },


  -- CodeCompanion dependencies
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Neovim 0.11+ has built-in treesitter highlight, just install parsers
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- CodeCompanion
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          azure_openai = function()
            return require("codecompanion.adapters").extend("azure_openai", {
              env = {
                api_key = "AZURE_OPENAI_API_KEY",
                endpoint = "AZURE_OPENAI_ENDPOINT",
              },
              schema = {
                model = {
                  default = "<your-deployment-name>",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "azure_openai",
          },
          inline = {
            adapter = "azure_openai",
          },
        },
      })
    end,
  },
}
