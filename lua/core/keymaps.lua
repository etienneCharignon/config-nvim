-- On définit notre touche leader sur espace
vim.g.mapleader = " "

-- Raccourci pour la fonction set
local keymap = vim.keymap.set

keymap("i", ";;", "<ESC>", { desc = "Sortir du mode insertion avec ;;" })
keymap("n", "<leader><Space>", ":nohl<CR>", { desc = "Effacer le surlignage de la recherche" })

-- Changement de fenêtre avec Ctrl + déplacement uniquement au lieu de Ctrl-w + déplacement
keymap("n", "<C-h>", "<C-w>h", { desc = "Déplace le curseur dans la fenêtre de gauche" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Déplace le curseur dans la fenêtre du bas" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Déplace le curseur dans la fenêtre du haut" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Déplace le curseur dans la fenêtre droite" })

-- Navigation entre les buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Macros Vim
-- @j - descend d'une ligne et répète la dernière commande
vim.fn.setreg('j', 'j.')
-- @f - répète le dernier f/F/t/T et répète la dernière commande
vim.fn.setreg('f', ';.')
-- @n - va à la prochaine occurrence et répète
vim.fn.setreg('n', 'n.')
-- @l - édition de liens Markdown
vim.fn.setreg('l', 'xf|cf/](f]2s)F[j')
-- @g - remplace " par '
vim.fn.setreg('g', 'f"r\',.')
-- @c - remplace ' par "
vim.fn.setreg('c', 'f\'r",.')
-- @s - active la sauvegarde automatique
vim.fn.setreg('s', ':autocmd TextChanged,TextChangedI <buffer> silent write')
-- @" - contient le nom du fichier courant
vim.fn.setreg('"', vim.fn.expand("%"))
