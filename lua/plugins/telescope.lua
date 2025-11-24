local grep_in_selected = function(prompt_bufnr)
  local actions_state = require("telescope.actions.state")
  local from_entry = require("telescope.from_entry")
  local builtin = require("telescope.builtin")

  local selected = {}
  for s in actions_state.get_current_picker(prompt_bufnr).manager:iter() do
    local filename = from_entry.path(s, false, false)
    table.insert(selected, filename)
  end

  builtin.live_grep({
    search_dirs = selected,
  })
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- fzf implémentation en C pour plus de rapidité
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {

        -- Parce que c'est joli
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-g>"] = grep_in_selected,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<C-p>",
      "<cmd>Telescope find_files<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de fichiers" }
    )
    keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fg",
      "<cmd>Telescope live_grep<cr>",
      { desc = "Recherche de chaînes de caractères dans le contenu des fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de buffers" }
    )
    keymap.set(
      "n",
      "<leader>fx",
      "<cmd>Telescope grep_string<cr>",
      { desc = "Recherche de la chaîne de caractères sous le curseur" }
    )
    keymap.set(
      "n",
      "<leader>fh",
      ":Telescope help_tags<CR>",
      { desc = "Recherche dans le help" })
  end,
}
