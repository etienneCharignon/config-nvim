" set mouse=a " Enable mouse support
" set clipboard=unnamedplus " Use system clipboard
filetype plugin on " Enable filetype detection and plugins
set cursorline " Highlight current line
set ttyfast " Speed up scrolling

set autoindent " sets newline to inherit the indentation of prev lines
set expandtab
set smartindent
set tabstop=4 " indents using 4 spaces
set shiftwidth=4 " sets 4 spaces indents when shifting
set smarttab " sets `tabstop` number of spaces when the tab is pressed
set softtabstop=4 " sets 4 spaces when tab or backspace is pressed

set number
set list listchars=tab:→\ ,trail:•,nbsp:¬
let mapleader = ","


" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

call plug#begin('~/.config/nvim/plugged')
" Plug 'https://github.com/preservim/nerdtree' " File explorer
" Plug 'https://github.com/nvim-tree/nvim-tree.lua' " File explorer
Plug 'https://github.com/nvim-neo-tree/neo-tree.nvim' " File explorer
Plug 'https://github.com/windwp/nvim-autopairs'
" neo-tree dependency
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-tree/nvim-web-devicons' " not strictly required, but recommended
Plug 'https://github.com/MunifTanjim/nui.nvim'
" fin neo-tree dependency

" Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/nvim-lualine/lualine.nvim' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS color preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Color schemes
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
" Plug 'https://github.com/tc50ca/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/nathangrigg/vim-beancount'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'https://github.com/williamboman/mason.nvim'
Plug 'https://github.com/williamboman/mason-lspconfig.nvim'

" Rust
" Plug 'https://github.com/williamboman/mason.nvim'
" Plug 'https://github.com/williamboman/mason-lspconfig.nvim'
Plug 'https://github.com/simrat39/rust-tools.nvim'

" LSP completion source:
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'

" Useful completion sources:
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-cmdline'

" Useful completion sources:
Plug 'https://github.com/hrsh7th/cmp-nvim-lua'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help'

" Completion framework:
Plug 'https://github.com/hrsh7th/nvim-cmp'

" for vnsip users
Plug 'https://github.com/hrsh7th/cmp-vsnip'
Plug 'https://github.com/hrsh7th/vim-vsnip'
call plug#end()

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|platforms|plugins|node_modules|vendor|venv|storage|tmp)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nnoremap <C-t> :Neotree toggle<CR>

nmap <F8> :TagbarToggle<CR>


" nnoremap <C-d> :lua vim.lsp.buf.definition()<CR>

" colorscheme gruvbox
colorscheme onedark
" colorscheme blue
" colorscheme github
" colorscheme slate

" macros
let @j = 'j.'
let @f = ';.'
let @n = 'n.'
let @l = 'xf|cf/](f]2s)F[j'
let @g = 'f"r'',.'
let @c = 'f''r",.'
let @s = ':autocmd TextChanged,TextChangedI <buffer> silent write'
let @" = expand("%")

autocmd BufNewFile,BufRead *.ofx set syntax=xml

lua << EOF
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()
require'lualine'.setup({
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diagnostic'},
        lualine_c = {
            { 'filename', path = 1 }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
})
require'nvim-autopairs'.setup{}

local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml", "ruby", "python", "javascript", "typescript" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    -- { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              -- path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_config = require('lspconfig')
local servers = {
    pyright = {},
    rust_analyzer = {},
    eslint = {
      cmd = { "node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server", "--stdio" },
      on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
          })
      end,
    },
    ruby_lsp = {
        cmd = { "bundle", "exec", "ruby-lsp" },
        filetypes = { "ruby", "eruby", "erb", "arb" }, -- Added eruby and erb for Rails views
        root_dir = lsp_config.util.root_pattern("Gemfile", ".git", "config/routes.rb"),
        init_options = {
            formatter = 'standard',
            linters = { 'standard' },
            enabledFeatures = {
              "documentHighlights",
              "documentSymbols",
              "foldingRanges",
              "selectionRanges",
              "semanticHighlighting",
              "formatting",
              "codeActions",
            },
          },
    },
}
for server, config in pairs(servers) do
    -- Merge capabilities with server-specific config
    config.capabilities = capabilities
    lsp_config[server].setup(config)
end
EOF

set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Highlight NonText (special charaters) avec treesitter
highlight NonText guifg=#e06c75 guibg=NONE gui=bold
