return {
  "nathangrigg/vim-beancount",
  opts = {},
  config = function()
    -- Désactiver le repliage par défaut pour les fichiers beancount
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "beancount",
      callback = function()
        vim.opt_local.foldenable = false
        -- Réinitialise regexpengine à la valeur par défaut (2) pour éviter les conflits avec cmp-cmdline
        -- vim-beancount définit regexpengine=1 qui est incompatible avec certains patterns regex de cmp-cmdline
        vim.opt_local.regexpengine = 2
      end,
    })
  end,
}
