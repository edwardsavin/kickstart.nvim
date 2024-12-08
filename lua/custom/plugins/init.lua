-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Codeium
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    -- Disable the default <Tab> keymap, use completions instead
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<A-CR>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
    end,
  },

  -- Tabout
  {
    'abecodes/tabout.nvim',
    lazy = false,
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
    dependencies = { -- These are optional
      'nvim-treesitter/nvim-treesitter',
      'L3MON4D3/LuaSnip',
      'hrsh7th/nvim-cmp',
    },
    opt = true, -- Set this to true if the plugin is optional
    event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    event = 'User FileOpened',
  },

  -- Alpha
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'RchrdAriza/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      local time = os.date '%H:%M'
      local date = os.date '%d/%m/%Y'
      local v = vim.version()
      local version = ' v' .. v.major .. '.' .. v.minor .. '.' .. v.patch

      -- Set header
      dashboard.section.header.val = {
        '███████╗██╗   ██╗███████╗██╗',
        '██╔════╝██║   ██║╚══███╔╝██║',
        '███████╗██║   ██║  ███╔╝ ██║',
        '╚════██║██║   ██║ ███╔╝  ██║',
        '███████║╚██████╔╝███████╗██║',
        '╚══════╝ ╚═════╝ ╚══════╝╚═╝',
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '󰮗   Find File', ':Telescope find_files<CR>'),
        dashboard.button('n', '   New File', ':ene!<CR>'),
        dashboard.button('p', '   Projects', ':Telescope repo<CR>'),
        dashboard.button('r', '   Recent Files', ':Telescope oldfiles<CR>'),
        dashboard.button('t', '󱘞   Find Text', ':Telescope live_grep<CR>'),
        dashboard.button('c', '   Configuration', ':e ~/.config/nvim/init.lua<CR>'),
        dashboard.button('q', '󰗼   Quit', ':qa<CR>'),
      }

      function centerText(text, width)
        local totalPadding = width - #text
        local leftPadding = math.floor(totalPadding / 2)
        local rightPadding = totalPadding - leftPadding
        return string.rep(' ', leftPadding) .. text .. string.rep(' ', rightPadding)
      end

      dashboard.section.footer.val = {
        centerText(time .. ' | ' .. date, 50),
        centerText(version, 50),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
    end,
  },

  -- Leap
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- Targets.vim
  {
    'wellle/targets.vim',
  },

  -- Lazygit
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  { 'cljoly/telescope-repo.nvim', lazy = true, dependencies = {
    'nvim-lua/plenary.nvim',
  } },
}
