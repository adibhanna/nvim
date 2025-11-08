return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "mix" -- Options: "original", "material", "mix", "afterglow"
      vim.g.gruvbox_material_cursor = "auto"

      -- vim.g.gruvbox_material_colors_override = { bg0 = '#16181A' } -- #0e1010
      -- vim.g.gruvbox_material_better_performance = 1

      -- vim.cmd.colorscheme("gruvbox-material")

      -- Custom statusline highlights
      -- vim.api.nvim_set_hl(0, "StatusLine", {
      --   bg = "#1C2021", -- Dark gray background
      --   fg = "#ebdbb2", -- Light text
      --   bold = false
      -- })
      --
      -- vim.api.nvim_set_hl(0, "StatusLineNC", {
      --   bg = "#1C2021", -- Darker background for inactive windows
      --   fg = "#928374", -- Muted text
      --   bold = false
      -- })
    end,
  },
  {
    'adibhanna/forest-night.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme forest-night')
    end,
  },
  {
    "RRethy/base16-nvim",
    enabled = false,
    config = function()
      vim.cmd('colorscheme base16-ayu-mirage')

      -- Get the base16 colors after setting the colorscheme
      local colors = require('base16-colorscheme').colors

      -- Map base16 colors to catppuccin-like names for easier reference
      local ayu_colors = {
        -- Background colors
        base = colors.base00,     -- main background
        mantle = colors.base01,   -- darker background for floating windows
        surface0 = colors.base02, -- surface color
        surface1 = colors.base03, -- lighter surface
        surface2 = colors.base04, -- even lighter surface

        -- Text colors
        text = colors.base05,     -- main text
        subtext1 = colors.base04, -- dimmer text
        subtext0 = colors.base03, -- even dimmer text

        -- Overlay colors
        overlay0 = colors.base03,
        overlay1 = colors.base04,
        overlay2 = colors.base06,

        -- Accent colors
        red = colors.base08,    -- red accent
        peach = colors.base09,  -- orange/peach accent
        yellow = colors.base0A, -- yellow accent
        green = colors.base0B,  -- green accent
        teal = colors.base0C,   -- teal/cyan accent
        blue = colors.base0D,   -- blue accent
        mauve = colors.base0E,  -- purple/mauve accent
      }

      -- Apply all the custom highlight groups
      local highlights = {
        -- Completion menu styling
        Pmenu = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        PmenuSel = { bg = ayu_colors.surface0, fg = ayu_colors.text },
        PmenuSbar = { bg = ayu_colors.surface0 },
        PmenuThumb = { bg = ayu_colors.surface2 },
        PmenuExtra = { bg = ayu_colors.mantle, fg = ayu_colors.subtext1 },

        -- Floating windows
        NormalFloat = { bg = ayu_colors.mantle },
        FloatBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        FloatTitle = { bg = ayu_colors.mantle, fg = ayu_colors.text },

        -- Blink.cmp specific highlighting
        BlinkCmpMenu = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        BlinkCmpMenuBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        BlinkCmpMenuSelection = { bg = ayu_colors.surface0, fg = ayu_colors.text },
        BlinkCmpScrollBarThumb = { bg = ayu_colors.surface2 },
        BlinkCmpScrollBarGutter = { bg = ayu_colors.surface0 },
        BlinkCmpLabel = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        BlinkCmpLabelDeprecated = { bg = ayu_colors.mantle, fg = ayu_colors.overlay0, strikethrough = true },
        BlinkCmpLabelDetail = { bg = ayu_colors.mantle, fg = ayu_colors.subtext1 },
        BlinkCmpLabelDescription = { bg = ayu_colors.mantle, fg = ayu_colors.subtext1 },
        BlinkCmpKind = { bg = ayu_colors.mantle, fg = ayu_colors.peach },
        BlinkCmpSource = { bg = ayu_colors.mantle, fg = ayu_colors.overlay1 },
        BlinkCmpGhostText = { fg = ayu_colors.overlay0, italic = true },
        BlinkCmpDoc = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        BlinkCmpDocBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        BlinkCmpDocSeparator = { bg = ayu_colors.mantle, fg = ayu_colors.surface1 },
        BlinkCmpDocCursorLine = { bg = ayu_colors.surface0 },
        BlinkCmpSignatureHelp = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        BlinkCmpSignatureHelpBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        BlinkCmpSignatureHelpActiveParameter = { bg = ayu_colors.surface0, fg = ayu_colors.peach, bold = true },

        -- Snacks.nvim picker NvChad style
        SnacksPicker = { bg = ayu_colors.base },
        SnacksPickerBorder = { fg = ayu_colors.surface0, bg = ayu_colors.base },
        SnacksPickerPreview = { bg = ayu_colors.base },
        SnacksPickerPreviewBorder = { fg = ayu_colors.base, bg = ayu_colors.base },
        SnacksPickerPreviewTitle = { fg = ayu_colors.base, bg = ayu_colors.green },
        SnacksPickerBoxBorder = { fg = ayu_colors.base, bg = ayu_colors.base },
        SnacksPickerInputBorder = { fg = ayu_colors.surface2, bg = ayu_colors.base },
        SnacksPickerInputSearch = { fg = ayu_colors.text, bg = ayu_colors.base },
        SnacksPickerList = { bg = ayu_colors.base },
        SnacksPickerListBorder = { fg = ayu_colors.base, bg = ayu_colors.base },
        SnacksPickerListTitle = { fg = ayu_colors.base, bg = ayu_colors.base },

        -- Additional picker elements
        SnacksPickerDir = { fg = ayu_colors.blue },
        SnacksPickerFile = { fg = ayu_colors.text },
        SnacksPickerMatch = { fg = ayu_colors.peach, bold = true },
        SnacksPickerCursor = { bg = ayu_colors.surface0, fg = ayu_colors.text },
        SnacksPickerSelected = { bg = ayu_colors.surface0, fg = ayu_colors.text },
        SnacksPickerIcon = { fg = ayu_colors.blue },
        SnacksPickerSource = { fg = ayu_colors.overlay1 },
        SnacksPickerCount = { fg = ayu_colors.overlay1 },
        SnacksPickerFooter = { fg = ayu_colors.overlay1 },
        SnacksPickerHeader = { fg = ayu_colors.text, bold = true },
        SnacksPickerSpecial = { fg = ayu_colors.peach },
        SnacksPickerIndent = { fg = ayu_colors.surface1 },
        SnacksPickerMulti = { fg = ayu_colors.peach },
        SnacksPickerTitle = { fg = ayu_colors.text, bold = true },
        SnacksPickerPrompt = { fg = ayu_colors.text },

        -- Snacks core components
        SnacksNotifierNormal = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        SnacksNotifierBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        SnacksNotifierTitle = { bg = ayu_colors.mantle, fg = ayu_colors.text, bold = true },
        SnacksNotifierIcon = { bg = ayu_colors.mantle, fg = ayu_colors.blue },
        SnacksNotifierIconInfo = { bg = ayu_colors.mantle, fg = ayu_colors.blue },
        SnacksNotifierIconWarn = { bg = ayu_colors.mantle, fg = ayu_colors.yellow },
        SnacksNotifierIconError = { bg = ayu_colors.mantle, fg = ayu_colors.red },

        -- Snacks Dashboard
        SnacksDashboardNormal = { bg = ayu_colors.base, fg = ayu_colors.text },
        SnacksDashboardDesc = { bg = ayu_colors.base, fg = ayu_colors.subtext1 },
        SnacksDashboardFile = { bg = ayu_colors.base, fg = ayu_colors.text },
        SnacksDashboardDir = { bg = ayu_colors.base, fg = ayu_colors.blue },
        SnacksDashboardFooter = { bg = ayu_colors.base, fg = ayu_colors.overlay1 },
        SnacksDashboardHeader = { bg = ayu_colors.base, fg = ayu_colors.text, bold = true },
        SnacksDashboardIcon = { bg = ayu_colors.base, fg = ayu_colors.blue },
        SnacksDashboardKey = { bg = ayu_colors.base, fg = ayu_colors.peach },
        SnacksDashboardTerminal = { bg = ayu_colors.base, fg = ayu_colors.text },
        SnacksDashboardSpecial = { bg = ayu_colors.base, fg = ayu_colors.peach },

        -- Snacks Terminal
        SnacksTerminalNormal = { bg = ayu_colors.mantle, fg = ayu_colors.text },
        SnacksTerminalBorder = { bg = ayu_colors.mantle, fg = ayu_colors.surface2 },
        SnacksTerminalTitle = { bg = ayu_colors.mantle, fg = ayu_colors.text, bold = true },

        -- Other UI elements
        CmpItemMenu = { fg = ayu_colors.surface2 },
        CursorLineNr = { fg = ayu_colors.text },
        GitSignsChange = { fg = ayu_colors.peach },
        LineNr = { fg = ayu_colors.overlay0 },
        LspInfoBorder = { link = "FloatBorder" },
        VertSplit = { bg = ayu_colors.base, fg = ayu_colors.surface0 },
        WhichKeyFloat = { bg = ayu_colors.mantle },
        YankHighlight = { bg = ayu_colors.surface2 },
        FidgetTask = { fg = ayu_colors.subtext1 },
        FidgetTitle = { fg = ayu_colors.peach },

        -- Indent guides
        IblIndent = { fg = ayu_colors.surface0 },
        IblScope = { fg = ayu_colors.overlay0 },

        -- Syntax highlighting
        Boolean = { fg = ayu_colors.mauve },
        Number = { fg = ayu_colors.mauve },
        Float = { fg = ayu_colors.mauve },

        PreProc = { fg = ayu_colors.mauve },
        PreCondit = { fg = ayu_colors.mauve },
        Include = { fg = ayu_colors.mauve },
        Define = { fg = ayu_colors.mauve },
        Conditional = { fg = ayu_colors.red },
        Repeat = { fg = ayu_colors.red },
        Keyword = { fg = ayu_colors.red },
        Typedef = { fg = ayu_colors.red },
        Exception = { fg = ayu_colors.red },
        Statement = { fg = ayu_colors.red },

        Error = { fg = ayu_colors.red },
        StorageClass = { fg = ayu_colors.peach },
        Tag = { fg = ayu_colors.peach },
        Label = { fg = ayu_colors.peach },
        Structure = { fg = ayu_colors.peach },
        Operator = { fg = ayu_colors.peach },
        Title = { fg = ayu_colors.peach },
        Special = { fg = ayu_colors.yellow },
        SpecialChar = { fg = ayu_colors.yellow },
        Type = { fg = ayu_colors.yellow, bold = true },
        Function = { fg = ayu_colors.green, bold = true },
        Delimiter = { fg = ayu_colors.subtext1 },
        Ignore = { fg = ayu_colors.subtext1 },
        Macro = { fg = ayu_colors.teal },

        -- Treesitter highlights
        TSAnnotation = { fg = ayu_colors.mauve },
        TSAttribute = { fg = ayu_colors.mauve },
        TSBoolean = { fg = ayu_colors.mauve },
        TSCharacter = { fg = ayu_colors.teal },
        TSCharacterSpecial = { link = "SpecialChar" },
        TSComment = { link = "Comment" },
        TSConditional = { fg = ayu_colors.red },
        TSConstBuiltin = { fg = ayu_colors.mauve },
        TSConstMacro = { fg = ayu_colors.mauve },
        TSConstant = { fg = ayu_colors.text },
        TSConstructor = { fg = ayu_colors.green },
        TSDebug = { link = "Debug" },
        TSDefine = { link = "Define" },
        TSEnvironment = { link = "Macro" },
        TSEnvironmentName = { link = "Type" },
        TSError = { link = "Error" },
        TSException = { fg = ayu_colors.red },
        TSField = { fg = ayu_colors.blue },
        TSFloat = { fg = ayu_colors.mauve },
        TSFuncBuiltin = { fg = ayu_colors.green },
        TSFuncMacro = { fg = ayu_colors.green },
        TSFunction = { fg = ayu_colors.green },
        TSFunctionCall = { fg = ayu_colors.green },
        TSInclude = { fg = ayu_colors.red },
        TSKeyword = { fg = ayu_colors.red },
        TSKeywordFunction = { fg = ayu_colors.red },
        TSKeywordOperator = { fg = ayu_colors.peach },
        TSKeywordReturn = { fg = ayu_colors.red },
        TSLabel = { fg = ayu_colors.peach },
        TSLiteral = { link = "String" },
        TSMath = { fg = ayu_colors.blue },
        TSMethod = { fg = ayu_colors.green },
        TSMethodCall = { fg = ayu_colors.green },
        TSNamespace = { fg = ayu_colors.yellow },
        TSNone = { fg = ayu_colors.text },
        TSNumber = { fg = ayu_colors.mauve },
        TSOperator = { fg = ayu_colors.peach },
        TSParameter = { fg = ayu_colors.text },
        TSParameterReference = { fg = ayu_colors.text },
        TSPreProc = { link = "PreProc" },
        TSProperty = { fg = ayu_colors.blue },
        TSPunctBracket = { fg = ayu_colors.text },
        TSPunctDelimiter = { link = "Delimiter" },
        TSPunctSpecial = { fg = ayu_colors.blue },
        TSRepeat = { fg = ayu_colors.red },
        TSStorageClass = { fg = ayu_colors.peach },
        TSStorageClassLifetime = { fg = ayu_colors.peach },
        TSStrike = { fg = ayu_colors.subtext1 },
        TSString = { fg = ayu_colors.teal },
        TSStringEscape = { fg = ayu_colors.green },
        TSStringRegex = { fg = ayu_colors.green },
        TSStringSpecial = { link = "SpecialChar" },
        TSSymbol = { fg = ayu_colors.text },
        TSTag = { fg = ayu_colors.peach },
        TSTagAttribute = { fg = ayu_colors.green },
        TSTagDelimiter = { fg = ayu_colors.green },
        TSText = { fg = ayu_colors.green },
        TSTextReference = { link = "Constant" },
        TSTitle = { link = "Title" },
        TSTodo = { link = "Todo" },
        TSType = { fg = ayu_colors.yellow, bold = true },
        TSTypeBuiltin = { fg = ayu_colors.yellow, bold = true },
        TSTypeDefinition = { fg = ayu_colors.yellow, bold = true },
        TSTypeQualifier = { fg = ayu_colors.peach, bold = true },
        TSURI = { fg = ayu_colors.blue },
        TSVariable = { fg = ayu_colors.text },
        TSVariableBuiltin = { fg = ayu_colors.mauve },
      }

      -- Apply all highlights
      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end
  },
  {
    "catppuccin/nvim",
    priority = 150,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        color_overrides = {
          latte = {
            rosewater = "#c14a4a",
            flamingo = "#c14a4a",
            red = "#c14a4a",
            maroon = "#c14a4a",
            pink = "#945e80",
            mauve = "#945e80",
            peach = "#c35e0a",
            yellow = "#b47109",
            green = "#6c782e",
            teal = "#4c7a5d",
            sky = "#4c7a5d",
            sapphire = "#4c7a5d",
            blue = "#45707a",
            lavender = "#45707a",
            text = "#654735",
            subtext1 = "#73503c",
            subtext0 = "#805942",
            overlay2 = "#8c6249",
            overlay1 = "#8c856d",
            overlay0 = "#a69d81",
            surface2 = "#bfb695",
            surface1 = "#d1c7a3",
            surface0 = "#e3dec3",
            base = "#f9f5d7",
            mantle = "#f0ebce",
            crust = "#e8e3c8",
          },
          mocha = {
            rosewater = "#ea6962",
            flamingo = "#ea6962",
            red = "#ea6962",
            maroon = "#ea6962",
            pink = "#d3869b",
            mauve = "#d3869b",
            peach = "#e78a4e",
            yellow = "#d8a657",
            green = "#a9b665",
            teal = "#89b482",
            sky = "#89b482",
            sapphire = "#89b482",
            blue = "#7daea3",
            lavender = "#7daea3",
            text = "#ebdbb2",
            subtext1 = "#d5c4a1",
            subtext0 = "#bdae93",
            overlay2 = "#a89984",
            overlay1 = "#928374",
            overlay0 = "#595959",
            surface2 = "#4d4d4d",
            surface1 = "#404040",
            surface0 = "#292929",
            base = "#1d2021",
            mantle = "#191b1c",
            crust = "#141617",
          },
        },
        transparent_background = false,
        show_end_of_buffer = false,
        integration_default = false,
        no_bold = true,
        no_italic = true,
        no_underline = true,
        integrations = {
          blink_cmp = {
            style = 'bordered',
          },
          snacks = {
            enabled = true,
            -- indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          },
          -- barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
          -- cmp = true,
          gitsigns = true,
          -- hop = true,
          -- illuminate = { enabled = true },
          native_lsp = { enabled = true, inlay_hints = { background = true } },
          -- neogit = true,
          -- neotree = true,
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,
          -- vimwiki = true,
          which_key = true,
          -- aerial = true,
          fidget = true,
          mason = true,
          neotest = true,
          dap_ui = true,
          -- telescope = {
          --   enabled = true,
          --   style = "nvchad",
          -- },
        },
        highlight_overrides = {
          all = function(colors)
            return {
              -- Completion menu styling
              Pmenu = { bg = colors.mantle, fg = colors.text },
              PmenuSel = { bg = colors.surface0, fg = colors.text },
              PmenuSbar = { bg = colors.surface0 },
              PmenuThumb = { bg = colors.surface2 },
              PmenuExtra = { bg = colors.mantle, fg = colors.subtext1 },

              -- Floating windows
              NormalFloat = { bg = colors.mantle },
              FloatBorder = { bg = colors.mantle, fg = colors.surface2 },
              FloatTitle = { bg = colors.mantle, fg = colors.text },

              -- Blink.cmp specific highlighting
              BlinkCmpMenu = { bg = colors.mantle, fg = colors.text },
              BlinkCmpMenuBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpMenuSelection = { bg = colors.surface0, fg = colors.text },
              BlinkCmpScrollBarThumb = { bg = colors.surface2 },
              BlinkCmpScrollBarGutter = { bg = colors.surface0 },
              BlinkCmpLabel = { bg = colors.mantle, fg = colors.text },
              BlinkCmpLabelDeprecated = { bg = colors.mantle, fg = colors.overlay0, strikethrough = true },
              BlinkCmpLabelDetail = { bg = colors.mantle, fg = colors.subtext1 },
              BlinkCmpLabelDescription = { bg = colors.mantle, fg = colors.subtext1 },
              BlinkCmpKind = { bg = colors.mantle, fg = colors.peach },
              BlinkCmpSource = { bg = colors.mantle, fg = colors.overlay1 },
              BlinkCmpGhostText = { fg = colors.overlay0, italic = true },
              BlinkCmpDoc = { bg = colors.mantle, fg = colors.text },
              BlinkCmpDocBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpDocSeparator = { bg = colors.mantle, fg = colors.surface1 },
              BlinkCmpDocCursorLine = { bg = colors.surface0 },
              BlinkCmpSignatureHelp = { bg = colors.mantle, fg = colors.text },
              BlinkCmpSignatureHelpBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpSignatureHelpActiveParameter = { bg = colors.surface0, fg = colors.peach, bold = true },

              -- Snacks.nvim picker NvChad style
              SnacksPicker = { bg = colors.base },
              SnacksPickerBorder = { fg = colors.surface0, bg = colors.base },
              SnacksPickerPreview = { bg = colors.base },
              SnacksPickerPreviewBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerPreviewTitle = { fg = colors.base, bg = colors.green },
              SnacksPickerBoxBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerInputBorder = { fg = colors.surface2, bg = colors.base },
              SnacksPickerInputSearch = { fg = colors.text, bg = colors.base },
              SnacksPickerList = { bg = colors.base },
              SnacksPickerListBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerListTitle = { fg = colors.base, bg = colors.base },

              -- Additional picker elements
              SnacksPickerDir = { fg = colors.blue },
              SnacksPickerFile = { fg = colors.text },
              SnacksPickerMatch = { fg = colors.peach, bold = true },
              SnacksPickerCursor = { bg = colors.surface0, fg = colors.text },
              SnacksPickerSelected = { bg = colors.surface0, fg = colors.text },
              SnacksPickerIcon = { fg = colors.blue },
              SnacksPickerSource = { fg = colors.overlay1 },
              SnacksPickerCount = { fg = colors.overlay1 },
              SnacksPickerFooter = { fg = colors.overlay1 },
              SnacksPickerHeader = { fg = colors.text, bold = true },
              SnacksPickerSpecial = { fg = colors.peach },
              SnacksPickerIndent = { fg = colors.surface1 },
              SnacksPickerMulti = { fg = colors.peach },
              SnacksPickerTitle = { fg = colors.text, bold = true },
              SnacksPickerPrompt = { fg = colors.text },

              -- Snacks core components
              SnacksNotifierNormal = { bg = colors.mantle, fg = colors.text },
              SnacksNotifierBorder = { bg = colors.mantle, fg = colors.surface2 },
              SnacksNotifierTitle = { bg = colors.mantle, fg = colors.text, bold = true },
              SnacksNotifierIcon = { bg = colors.mantle, fg = colors.blue },
              SnacksNotifierIconInfo = { bg = colors.mantle, fg = colors.blue },
              SnacksNotifierIconWarn = { bg = colors.mantle, fg = colors.yellow },
              SnacksNotifierIconError = { bg = colors.mantle, fg = colors.red },

              -- Snacks Dashboard
              SnacksDashboardNormal = { bg = colors.base, fg = colors.text },
              SnacksDashboardDesc = { bg = colors.base, fg = colors.subtext1 },
              SnacksDashboardFile = { bg = colors.base, fg = colors.text },
              SnacksDashboardDir = { bg = colors.base, fg = colors.blue },
              SnacksDashboardFooter = { bg = colors.base, fg = colors.overlay1 },
              SnacksDashboardHeader = { bg = colors.base, fg = colors.text, bold = true },
              SnacksDashboardIcon = { bg = colors.base, fg = colors.blue },
              SnacksDashboardKey = { bg = colors.base, fg = colors.peach },
              SnacksDashboardTerminal = { bg = colors.base, fg = colors.text },
              SnacksDashboardSpecial = { bg = colors.base, fg = colors.peach },

              -- Snacks Terminal
              SnacksTerminalNormal = { bg = colors.mantle, fg = colors.text },
              SnacksTerminalBorder = { bg = colors.mantle, fg = colors.surface2 },
              SnacksTerminalTitle = { bg = colors.mantle, fg = colors.text, bold = true },

              CmpItemMenu = { fg = colors.surface2 },
              CursorLineNr = { fg = colors.text },
              GitSignsChange = { fg = colors.peach },
              LineNr = { fg = colors.overlay0 },
              LspInfoBorder = { link = "FloatBorder" },
              VertSplit = { bg = colors.base, fg = colors.surface0 },
              WhichKeyFloat = { bg = colors.mantle },
              YankHighlight = { bg = colors.surface2 },
              FidgetTask = { fg = colors.subtext1 },
              FidgetTitle = { fg = colors.peach },

              IblIndent = { fg = colors.surface0 },
              IblScope = { fg = colors.overlay0 },

              Boolean = { fg = colors.mauve },
              Number = { fg = colors.mauve },
              Float = { fg = colors.mauve },

              PreProc = { fg = colors.mauve },
              PreCondit = { fg = colors.mauve },
              Include = { fg = colors.mauve },
              Define = { fg = colors.mauve },
              Conditional = { fg = colors.red },
              Repeat = { fg = colors.red },
              Keyword = { fg = colors.red },
              Typedef = { fg = colors.red },
              Exception = { fg = colors.red },
              Statement = { fg = colors.red },

              Error = { fg = colors.red },
              StorageClass = { fg = colors.peach },
              Tag = { fg = colors.peach },
              Label = { fg = colors.peach },
              Structure = { fg = colors.peach },
              Operator = { fg = colors.peach },
              Title = { fg = colors.peach },
              Special = { fg = colors.yellow },
              SpecialChar = { fg = colors.yellow },
              Type = { fg = colors.yellow, style = { "bold" } },
              Function = { fg = colors.green, style = { "bold" } },
              Delimiter = { fg = colors.subtext1 },
              Ignore = { fg = colors.subtext1 },
              Macro = { fg = colors.teal },

              TSAnnotation = { fg = colors.mauve },
              TSAttribute = { fg = colors.mauve },
              TSBoolean = { fg = colors.mauve },
              TSCharacter = { fg = colors.teal },
              TSCharacterSpecial = { link = "SpecialChar" },
              TSComment = { link = "Comment" },
              TSConditional = { fg = colors.red },
              TSConstBuiltin = { fg = colors.mauve },
              TSConstMacro = { fg = colors.mauve },
              TSConstant = { fg = colors.text },
              TSConstructor = { fg = colors.green },
              TSDebug = { link = "Debug" },
              TSDefine = { link = "Define" },
              TSEnvironment = { link = "Macro" },
              TSEnvironmentName = { link = "Type" },
              TSError = { link = "Error" },
              TSException = { fg = colors.red },
              TSField = { fg = colors.blue },
              TSFloat = { fg = colors.mauve },
              TSFuncBuiltin = { fg = colors.green },
              TSFuncMacro = { fg = colors.green },
              TSFunction = { fg = colors.green },
              TSFunctionCall = { fg = colors.green },
              TSInclude = { fg = colors.red },
              TSKeyword = { fg = colors.red },
              TSKeywordFunction = { fg = colors.red },
              TSKeywordOperator = { fg = colors.peach },
              TSKeywordReturn = { fg = colors.red },
              TSLabel = { fg = colors.peach },
              TSLiteral = { link = "String" },
              TSMath = { fg = colors.blue },
              TSMethod = { fg = colors.green },
              TSMethodCall = { fg = colors.green },
              TSNamespace = { fg = colors.yellow },
              TSNone = { fg = colors.text },
              TSNumber = { fg = colors.mauve },
              TSOperator = { fg = colors.peach },
              TSParameter = { fg = colors.text },
              TSParameterReference = { fg = colors.text },
              TSPreProc = { link = "PreProc" },
              TSProperty = { fg = colors.blue },
              TSPunctBracket = { fg = colors.text },
              TSPunctDelimiter = { link = "Delimiter" },
              TSPunctSpecial = { fg = colors.blue },
              TSRepeat = { fg = colors.red },
              TSStorageClass = { fg = colors.peach },
              TSStorageClassLifetime = { fg = colors.peach },
              TSStrike = { fg = colors.subtext1 },
              TSString = { fg = colors.teal },
              TSStringEscape = { fg = colors.green },
              TSStringRegex = { fg = colors.green },
              TSStringSpecial = { link = "SpecialChar" },
              TSSymbol = { fg = colors.text },
              TSTag = { fg = colors.peach },
              TSTagAttribute = { fg = colors.green },
              TSTagDelimiter = { fg = colors.green },
              TSText = { fg = colors.green },
              TSTextReference = { link = "Constant" },
              TSTitle = { link = "Title" },
              TSTodo = { link = "Todo" },
              TSType = { fg = colors.yellow, style = { "bold" } },
              TSTypeBuiltin = { fg = colors.yellow, style = { "bold" } },
              TSTypeDefinition = { fg = colors.yellow, style = { "bold" } },
              TSTypeQualifier = { fg = colors.peach, style = { "bold" } },
              TSURI = { fg = colors.blue },
              TSVariable = { fg = colors.text },
              TSVariableBuiltin = { fg = colors.mauve },

              ["@annotation"] = { link = "TSAnnotation" },
              ["@attribute"] = { link = "TSAttribute" },
              ["@boolean"] = { link = "TSBoolean" },
              ["@character"] = { link = "TSCharacter" },
              ["@character.special"] = { link = "TSCharacterSpecial" },
              ["@comment"] = { link = "TSComment" },
              ["@conceal"] = { link = "Grey" },
              ["@conditional"] = { link = "TSConditional" },
              ["@constant"] = { link = "TSConstant" },
              ["@constant.builtin"] = { link = "TSConstBuiltin" },
              ["@constant.macro"] = { link = "TSConstMacro" },
              ["@constructor"] = { link = "TSConstructor" },
              ["@debug"] = { link = "TSDebug" },
              ["@define"] = { link = "TSDefine" },
              ["@error"] = { link = "TSError" },
              ["@exception"] = { link = "TSException" },
              ["@field"] = { link = "TSField" },
              ["@float"] = { link = "TSFloat" },
              ["@function"] = { link = "TSFunction" },
              ["@function.builtin"] = { link = "TSFuncBuiltin" },
              ["@function.call"] = { link = "TSFunctionCall" },
              ["@function.macro"] = { link = "TSFuncMacro" },
              ["@include"] = { link = "TSInclude" },
              ["@keyword"] = { link = "TSKeyword" },
              ["@keyword.function"] = { link = "TSKeywordFunction" },
              ["@keyword.operator"] = { link = "TSKeywordOperator" },
              ["@keyword.return"] = { link = "TSKeywordReturn" },
              ["@label"] = { link = "TSLabel" },
              ["@math"] = { link = "TSMath" },
              ["@method"] = { link = "TSMethod" },
              ["@method.call"] = { link = "TSMethodCall" },
              ["@namespace"] = { link = "TSNamespace" },
              ["@none"] = { link = "TSNone" },
              ["@number"] = { link = "TSNumber" },
              ["@operator"] = { link = "TSOperator" },
              ["@parameter"] = { link = "TSParameter" },
              ["@parameter.reference"] = { link = "TSParameterReference" },
              ["@preproc"] = { link = "TSPreProc" },
              ["@property"] = { link = "TSProperty" },
              ["@punctuation.bracket"] = { link = "TSPunctBracket" },
              ["@punctuation.delimiter"] = { link = "TSPunctDelimiter" },
              ["@punctuation.special"] = { link = "TSPunctSpecial" },
              ["@repeat"] = { link = "TSRepeat" },
              ["@storageclass"] = { link = "TSStorageClass" },
              ["@storageclass.lifetime"] = { link = "TSStorageClassLifetime" },
              ["@strike"] = { link = "TSStrike" },
              ["@string"] = { link = "TSString" },
              ["@string.escape"] = { link = "TSStringEscape" },
              ["@string.regex"] = { link = "TSStringRegex" },
              ["@string.special"] = { link = "TSStringSpecial" },
              ["@symbol"] = { link = "TSSymbol" },
              ["@tag"] = { link = "TSTag" },
              ["@tag.attribute"] = { link = "TSTagAttribute" },
              ["@tag.delimiter"] = { link = "TSTagDelimiter" },
              ["@text"] = { link = "TSText" },
              ["@text.danger"] = { link = "TSDanger" },
              ["@text.diff.add"] = { link = "diffAdded" },
              ["@text.diff.delete"] = { link = "diffRemoved" },
              ["@text.emphasis"] = { link = "TSEmphasis" },
              ["@text.environment"] = { link = "TSEnvironment" },
              ["@text.environment.name"] = { link = "TSEnvironmentName" },
              ["@text.literal"] = { link = "TSLiteral" },
              ["@text.math"] = { link = "TSMath" },
              ["@text.note"] = { link = "TSNote" },
              ["@text.reference"] = { link = "TSTextReference" },
              ["@text.strike"] = { link = "TSStrike" },
              ["@text.strong"] = { link = "TSStrong" },
              ["@text.title"] = { link = "TSTitle" },
              ["@text.todo"] = { link = "TSTodo" },
              ["@text.todo.checked"] = { link = "Green" },
              ["@text.todo.unchecked"] = { link = "Ignore" },
              ["@text.underline"] = { link = "TSUnderline" },
              ["@text.uri"] = { link = "TSURI" },
              ["@text.warning"] = { link = "TSWarning" },
              ["@todo"] = { link = "TSTodo" },
              ["@type"] = { link = "TSType" },
              ["@type.builtin"] = { link = "TSTypeBuiltin" },
              ["@type.definition"] = { link = "TSTypeDefinition" },
              ["@type.qualifier"] = { link = "TSTypeQualifier" },
              ["@uri"] = { link = "TSURI" },
              ["@variable"] = { link = "TSVariable" },
              ["@variable.builtin"] = { link = "TSVariableBuiltin" },

              ["@lsp.type.class"] = { link = "TSType" },
              ["@lsp.type.comment"] = { link = "TSComment" },
              ["@lsp.type.decorator"] = { link = "TSFunction" },
              ["@lsp.type.enum"] = { link = "TSType" },
              ["@lsp.type.enumMember"] = { link = "TSProperty" },
              ["@lsp.type.events"] = { link = "TSLabel" },
              ["@lsp.type.function"] = { link = "TSFunction" },
              ["@lsp.type.interface"] = { link = "TSType" },
              ["@lsp.type.keyword"] = { link = "TSKeyword" },
              ["@lsp.type.macro"] = { link = "TSConstMacro" },
              ["@lsp.type.method"] = { link = "TSMethod" },
              ["@lsp.type.modifier"] = { link = "TSTypeQualifier" },
              ["@lsp.type.namespace"] = { link = "TSNamespace" },
              ["@lsp.type.number"] = { link = "TSNumber" },
              ["@lsp.type.operator"] = { link = "TSOperator" },
              ["@lsp.type.parameter"] = { link = "TSParameter" },
              ["@lsp.type.property"] = { link = "TSProperty" },
              ["@lsp.type.regexp"] = { link = "TSStringRegex" },
              ["@lsp.type.string"] = { link = "TSString" },
              ["@lsp.type.struct"] = { link = "TSType" },
              ["@lsp.type.type"] = { link = "TSType" },
              ["@lsp.type.typeParameter"] = { link = "TSTypeDefinition" },
              ["@lsp.type.variable"] = { link = "TSVariable" },
            }
          end,
          latte = function(colors)
            return {
              IblIndent = { fg = colors.mantle },
              IblScope = { fg = colors.surface1 },

              LineNr = { fg = colors.surface1 },
            }
          end,
        },
      })
      -- vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "none", fg = "#eedaad" })
      -- vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "none", fg = "#eedaad" })
      -- vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "none", fg = "#eedaad" })

      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').setup({
        -- This callback can be used to override the colors used in the base palette.
        on_palette = function(palette) end,
        -- This callback can be used to override the colors used in the extended palette.
        after_palette = function(palette) end,
        -- This callback can be used to override highlights before they are applied.
        on_highlight = function(highlights, palette) end,
        -- Enable bold keywords.
        bold_keywords = false,
        -- Enable italic comments.
        italic_comments = false,
        -- Enable editor background transparency.
        transparent = {
          -- Enable transparent background.
          bg = false,
          -- Enable transparent background for floating windows.
          float = false,
        },
        -- Enable brighter float border.
        bright_border = false,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = true,
        -- Swap the dark background with the normal one.
        swap_backgrounds = false,
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = false,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = 'dark',
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = 'flat',
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'flat',
        },
        leap = {
          -- Dims the backdrop when using leap.
          dim_backdrop = false,
        },
        ts_context = {
          -- Enables dark background for treesitter-context window
          dark_background = true,
        }
      })
      -- require('nordic').load()
    end
  },

  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Default options
      require('github-theme').setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath('cache') .. '/github-theme',
          compile_file_suffix = '_compiled', -- Compiled file suffix
          hide_end_of_buffer = true,   -- Hide the '~' character at the end of the buffer for a cleaner look
          hide_nc_statusline = true,   -- Override the underline style for non-active statuslines
          transparent = false,         -- Disable setting bg (make neovim's background transparent)
          terminal_colors = true,      -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,        -- Non focused panes set to alternative background
          module_default = true,       -- Default enable value for modules
          styles = {                   -- Style to be applied to different syntax groups
            comments = 'NONE',         -- Value is any valid attr-list value `:help attr-list`
            functions = 'NONE',
            keywords = 'NONE',
            variables = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = { -- Darken floating windows and sidebar-like windows
            floats = true,
            sidebars = {
              enable = true,
              list = {}, -- Apply dark background to specific windows
            },
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
      -- vim.cmd('colorscheme github_dark_dimmed') -- vim.cmd('colorscheme github_dark')
    end,
  }
}
