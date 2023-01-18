-- for tabs to be 2 spaces
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2


-- set languagetool server jar
vim.g.languagetool_server_jar = '/usr/share/java/languagetool/languagetool-server.jar'

-- minimap settings
-- vim.g.minimap_width = 10
-- vim.g.minimap_auto_start = 1
-- vim.g.minimap_auto_start_win_enter = 1

-- dashboard
-- vim.g.dashboard_default_executive = 'telescope'

-- sets up keymaps
local keymap = vim.api.nvim_set_keymap
-- makes it so that Ctrl + s saves doc
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})
local opts = { noremap = true }
-- makes it so that you can change split tabs (:split or :vsp) using ctrl + h,j,k,l
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

-- LSP settings
keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- xnoremap <leader>ca <Cmd>lua vim.lsp.buf.range_code_action()<CR>
-- fix above line
keymap('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)


-- nvim tabs go back and forth
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'fg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'tt', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'TT', ':ToggleTerm<CR>', {noremap = true, silent = true})

-- arduino keymaps
vim.api.nvim_set_keymap('n', 'aa', ':ArduinoAttach<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'am', ':ArduinoVerify<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ac', ':ArduinoCompile<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'au', ':ArduinoUpload<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ad', ':ArduinoUploadAndSerial<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ab', ':ArduinoChooseBoard<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ap', ':ArduinoChooseProgrammer<CR>', {noremap = true, silent = true})

-- vim-move keymaps
vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })

local async = require "plenary.async"

-- we will now add packer
require('packer').startup(function()

  -- packer
  use 'wbthomason/packer.nvim'

  -- ####### color scheme ####### --
  -- rose-pine theme
  use({
      'rose-pine/neovim',
      as = 'rose-pine',
      tag = 'v1.*',
  })
  use({
      "catppuccin/nvim",
      as = "catppuccin"
  })
  use({
      "Mofiqul/dracula.nvim",
      as = "dracula"
  })

  use 'nvim-lua/plenary.nvim'

  -- nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }

  -- bufferline
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- nvim-autopairs
  use {
    'windwp/nvim-autopairs',
  }

  -- toggleterm
  use {"akinsho/toggleterm.nvim"}

  -- indent blanklines
  use 'lukas-reineke/indent-blankline.nvim'

  -- use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  -- use 'williamboman/nvim-lsp-installer' -- LSP easy installer
  use {
    "williamboman/nvim-lsp-installer",
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvim-lsp-installer").setup {}
            local lspconfig = require("lspconfig")
            lspconfig.sumneko_lua.setup {}
        end
    }
}
  use 'hrsh7th/nvim-cmp' -- autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- lsp source for cmp
  use 'hrsh7th/cmp-buffer' -- buffer source for cmp
  use 'uga-rosa/cmp-dictionary' -- dictionary source for cmp
  use 'hrsh7th/cmp-vsnip' -- vsnip
  use 'hrsh7th/vim-vsnip' -- vsnip
  use 'onsails/lspkind.nvim' -- lspkind

  use 'andweeb/presence.nvim' -- use discord rich presence for neovim

  use {'neoclide/coc.nvim', branch = 'release'} -- coc autocompletion
  use {'tjdevries/coc-zsh'} -- coc autocompletion for zsh

  use "lukas-reineke/lsp-format.nvim"

  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- use 'p00f/nvim-ts-rainbow' -- rainbow matching brackets
  use 'nvim-treesitter/nvim-treesitter' -- neovim treesitter
  use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'} -- rainbow matching brackets


  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  } -- which-key

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  } -- telescope

  use {'sbdchd/neoformat'} -- neoformat

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  } -- null-ls (Neovim language server)

  -- use {'glepnir/dashboard-nvim'} -- dashboard
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.theta'.config)
    end
  }

  use {'MunifTanjim/prettier.nvim'} -- prettier formatter

  use {'vlelo/arduino-helper.nvim'} -- arduino helper

  -- use {'iamcco/markdown-preview.nvim'} -- markdown support
  use {"ellisonleao/glow.nvim", branch = 'main'} -- glow
  use {'iamcco/markdown-preview.nvim'}

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  use {
    "folke/todo-comments.nvim",
    -- requires = "nvim-lua/plenary.nvim",
    -- config = function()
    --   require("todo-comments").setup {
    --     signs = true,
	  --         sign_priority = 8,
	  --
	  --         keywords = {
	  --           FIX = {
	  -- icon = "",
	  --           color = "error"
	  --         },
	  --         TODO = { icon = "", color = "info" },
	  --         HACK = { icon = "", color = "warning" },
	  --         WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
	  --         PERF = { icon = "", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"} },
	  --         NOTE = { icon = "", color = "hint", alt = { "INFO" } },
	  --         },
	  --         merg_keywords = true,
	  --         highlight = {
	  --           before = "bg",
	  --           keyword = "wide",
	  --           after = "fg",
	  --         },
	  --         colors = {
	  --           error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
	  --           warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
	  --           info = { "DiagnosticInfo", "#2563EB" },
	  --           hint = { "DiagnosticHint", "#10B981" },
	  --           default = { "Identifier", "#7C3AED" },
	  --         }, 
    --   }
    -- end
  } -- todo-comments

  use {'terrortylor/nvim-comment'} -- comment

  use {'vigoux/LanguageTool.nvim'} -- LanguageTool

  use {'mfussenegger/nvim-jdtls'} -- jdtls


  --  use {'wfxr/minimap.vim'} -- minimap powered by code-minimap

  use 'fedepujol/move.nvim'

  use {"mg979/vim-visual-multi", branch = 'master'} -- visual multi

  -- latex
  use {'lervag/vimtex'} -- vimtex

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  } -- firenvim

  use 'dylanaraps/pascal_lint.nvim' -- pascal

  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  -- OpenSCAD
  use {
    'salkin-mada/openscad.nvim',
    config = function ()
        require('openscad')
        -- load snippets, note requires
        vim.g.openscad_load_snippets = true
    end,
    requires = 'L3MON4D3/LuaSnip'
  }

  -- setup Dart/Flutter
  -- use 'dart-lang/dart-vim-plugin'

  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- auto-save
  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {

      }
      end,
  })
end)

vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99 -- feel free to decrease the value
vim.wo.foldenable = true
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

require("flutter-tools").setup {
  ui = {
    border = 'rounded',
    notification_style = 'plugin'
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    }
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = {}
  },
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "ErrorMsg",
    prefix = " > ",
    enabled = true,
  },
  dev_log = {
    open_cmd = "tabedit",
  },
  outline = {
    -- open on right side of the editor
    open_cmd = "30vnew",
    auto_open = false,
    position = "right",
  },
  lsp = {
    color = {
      enabled = true,
      background = true,
      foreground = false,
      virtual_text = true,
      virtual_text_str = " ",
    },
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFileWithClasses = "prompt",
      enableSnippets = true,
    },
  },
}

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  expand_level = 1,
  -- expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})


function _G.statusLine()
  return vim.g.flutter_tools_decorations.app_version
end

vim.opt.statusline ='%!v:statusLine()'

require('ufo').setup()

-- comment
require('nvim_comment').setup()

-- neovim tree settings
require'nvim-tree'.setup {
  auto_reload_on_write = true,
  sort_by = "name",
  view = {
    width = 25,
    side = "right"
  }
}

-- bufferline settings
require'bufferline'.setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_allign = "center",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil
      },
      separator_style = "slant"
    }
  }
}

-- nvim-autopairs settings
require'nvim-autopairs'.setup {}

-- toggleterm
require("toggleterm").setup{}

-- indent blankline
require("indent_blankline").setup {
    show_end_of_line = true,
    show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    }
}

-- lsp config
require'lspconfig'.pyright.setup{}
vim.o.completeopt = "menuone,noselect"

-- Discord Rich Presence
require("presence"):setup({
    -- General options
    auto_update         = true,
    neovim_image_text   = "The One True Text Editor",
    main_image          = "neovim",
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = true,
    blacklist           = {},
    buttons             = false,
    file_assets         = {},

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})

require("lsp-format").setup {}
require "lspconfig".gopls.setup { on_attach = require "lsp-format".on_attach }
require'lspconfig'.bashls.setup{}
require('lualine').setup()

require("nvim-treesitter.configs").setup {
  --highlight = {
  --},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.mouse = 'a'

 -- allow undo file
vim.opt.undofile = true

-- pride flag
 vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
 vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
 vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
 vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
 vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
 vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- trans flag
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#55CDFC gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#F7A8B8 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#FFFFFF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#F7A8B8 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#55CDFC gui=nocombine]]

-- helpful tooltips for which-key
local wk = require("which-key")
local mappings = {
  l = {
    name = "LSP",
    i = {":LspInfo<cr>", "Connected Language Servers"},
    k = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help"},
    K = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"},
    w = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add workspace folder"},
    W = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove workspace folder"},
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      "List workspace folder"
    },
    t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type definition"},
    d = {'<cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition"},
    D = {'<cmd>lua vim.lsp.buf.delaration()<CR>', "Go to declaration"},
    r = {'<cmd>lua vim.lsp.buf.references()<CR>', "References"},
    R = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
    a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions"},
    e = {'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', "Show line diagnostics"},
    n = {'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', "Go to next diagnostic"},
    N = {'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', "Go to previous diagnostic"},
    I = {'<cmd>LspInstallInfo<cr>', 'Install language server'}
  },
  x = {":bdelete<cr>", "Close Buffer"},
  X = {":bdelete!<cr>", "Force Close Buffer"},
  q = {":q<cr>", "Quit"},
  Q = {":q!<cr>", "Force Quit"},
  w = {":w<cr>", "Write"},
  E = {":e ~/.config/nvim/lua/vapour/user-config/init.lua<cr>", "Edit User Config"},
  p = {
    name = "Packer",
    r = {":PackerClean<cr>", "Remove Unused Plugins"},
    c = {":PackerCompile profile=true<cr>", "Recompile Plugins"},
    i = {":PackerInstall<cr>", "Install Plugins"},
    p = {":PackerProfile<cr>", "Packer Profile"},
    s = {":PackerSync<cr>", "Sync Plugins"},
    S = {":PackerStatus<cr>", "Packer Status"},
    u = {":PackerUpdate<cr>", "Update Plugins"}
  },
}
local opts_help = {prefix = "<leader>"}
wk.register(mappings, opts_help)

-- null-ls setup
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
    },
})
 
require("arduino-helper").setup{
  ui = "telescope",
}

-- function! WC()
--   let filename = expand("%")
--   let cmd = "detex " . filename . " | wc -w | tr -d '[:space:]'"
--   let result = system(cmd)
--   echo result . " words"
-- endfunction
--
-- command WC call WC()

-- local cmp = require("cmp")
-- local lspkind = require("lspkind")
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- for `vsnip` users
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-Space>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.abort(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'path' },
--     { name = 'vsnip' },
--     { name = 'arduino-helper' },
--     { name = 'cmp' },
--     { name = 'lspkind' },
--     { name = 'lsp_extensions' },
--     { name = 'dictionary'}
--   }, {
--     { name = 'buffer' },
--   }),
--   cmp.setup.filetype('latex', {
--     sources = cmp.config.sources({
--       { name = 'dictionary' },
--     }, {
--       { name = 'buffer' },
--     })
--     }),
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = 'symbol',
--       maxwidth = 100,
--       before = function (entry, vim_item)
--         return vim_item
--       end
--     })
--   }
-- })

-- coc-lua setup

vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

-- usse mouse to select multiple lines
vim.g.VM_mouse_mappings = 1

vim.g.openscad_default_mappings = true

-- vim.cmd('colorscheme rose-pine')
vim.g.closetag_flavour = "mocha"
vim.g.catppuccino_flavour = "mocha"
require("catppuccin").setup({
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
  },
})
vim.cmd('colorscheme catppuccin')
vim.cmd('Catppuccin mocha')

-- if returned in complete menu, the execute <C-y>
-- inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
-- do this using lua
vim.api.nvim_set_keymap('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "<cr>"', {expr = true, noremap = true})
