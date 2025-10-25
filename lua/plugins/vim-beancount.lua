return {
  "nathangrigg/vim-beancount",
  opts = {},
  config = function()
    -- Désactiver le repliage par défaut pour les fichiers beancount
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "beancount",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
  end,
}
