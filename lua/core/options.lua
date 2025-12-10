local opt = vim.opt -- raccourci pour un peu plus de concision

-- numéros de ligne
opt.relativenumber = false
opt.number = true

-- tabs & indentation
opt.tabstop = 2       -- 2 espaces pour les tabulations
opt.shiftwidth = 2    -- 2 espaces pour la taille des indentations
opt.expandtab = true  -- change les tabulations en espaces (don't feed the troll please ;) )
opt.autoindent = true -- on garde l'indentation actuelle à la prochaine ligne

-- recherche
opt.ignorecase = true -- ignore la casse quand on recherche
opt.smartcase = true  -- sauf quand on fait une recherche avec des majuscules, on rebascule en sensible à la casse
opt.hlsearch = true   -- surlignage de toutes les occurences de la recherche en cours

-- ligne du curseur
opt.cursorline = true -- surlignage de la ligne active

-- apparence

-- termguicolors est nécessaire pour que les thèmes modernes fonctionnent
opt.termguicolors = true
opt.background = "dark" -- dark ou light en fonction de votre préférence
opt.signcolumn = "yes"  -- affiche une colonne en plus à gauche pour afficher les signes (évite de décaler le texte)

-- retour
opt.backspace = "indent,eol,start" -- on autorise l'utilisation de retour quand on indente, à la fin de ligne ou au début

-- presse papier
opt.clipboard = "unnamedplus" -- on utilise le presse papier du système par défaut

-- split des fenêtres
opt.splitright = true     -- le split vertical d'une fenêtre s'affiche à droite
opt.splitbelow = true     -- le split horizontal d'une fenêtre s'affiche en bas

opt.swapfile = false      -- on supprime le pénible fichier de swap

opt.undofile = true       -- on autorise l'undo à l'infini (même quand on revient sur un fichier qu'on avait fermé)

opt.iskeyword:append("-") -- on traite les mots avec des - comme un seul mot

-- affichage des caractères spéciaux
opt.list = true
opt.listchars:append({ nbsp = "␣", trail = "•", precedes = "«", extends = "»", tab = "> " })

-- Auto-commandes
-- Définit la syntaxe XML pour les fichiers .ofx
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.ofx",
  callback = function()
    vim.bo.syntax = "xml"
  end,
})

-- Définit le filetype javascript pour les fichiers .js.erb
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.js.erb",
  callback = function()
    vim.bo.filetype = "javascript"
  end,
})

-- Définit le filetype ruby pour les fichiers .html.arb
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.arb",
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- Colore les espaces en fin de ligne et insécables en warning
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    -- Récupère la couleur orange du groupe DiagnosticWarn du thème actuel
    local warn_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
    local more_msg = vim.api.nvim_get_hl(0, { name = "Comment" })
    vim.api.nvim_set_hl(0, "Whitespace", { fg = warn_hl.fg })
    vim.api.nvim_set_hl(0, "LineNr", { fg = more_msg.fg })
  end,
})
