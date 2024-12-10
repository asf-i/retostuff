inoremap kj <Esc>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap m :NERDTreeFocus<CR>

set number
set relativenumber
set autoindent
set foldmethod=indent
set foldlevel=20
set mouse=a
set clipboard+=unnamedplus

syntax on

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'joshdick/onedark.vim'
Plug 'AlexvZyl/nordic.nvim'
Plug 'catppuccin/nvim'
Plug 'folke/tokyonight.nvim'
Plug 'joshdick/onedark.vim'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF

lua << EOF
-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
	capabilities = capabilities
  }
  require('lspconfig')['bashls'].setup {}
  require('lspconfig')['vimls'].setup {}
  require('lspconfig')['lua_ls'].setup {}
  require('lspconfig')['html'].setup {
	capabilities = capabilities
  }
  require('lspconfig')['cssls'].setup {
	capabilities = capabilities
  }
  require('lspconfig')['ts_ls'].setup {
	  capabilities = capabilities
  }
EOF

lua << EOF
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "html", "javascript", "css" },
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
})
require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
EOF

colorscheme nordic
highlight Normal guibg=NONE

