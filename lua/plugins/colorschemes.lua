-- Colorschemes: Theme configurations
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Yukinord (default)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "adibhanna/yukinord.nvim",
    config = function()
      require("yukinord").setup({
        transparent = true,
        transparent_sidebar = true,
      })
      -- vim.cmd("colorscheme yukinord")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Gruvbox Material
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "mix"
      vim.g.gruvbox_material_cursor = "auto"
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Forest Night
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "adibhanna/forest-night.nvim",
    priority = 1000,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Catppuccin (with custom gruvbox-inspired colors)
  -- ════════════════════════════════════════════════════════════════════════════
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
          -- Yukinord-inspired mocha (Nord-based dark theme)
          mocha = {
            -- Accent colors from Yukinord
            rosewater = "#d08770", -- orange variant
            flamingo = "#d08770",  -- orange
            red = "#bf616a",       -- yukinord red
            maroon = "#bf616a",    -- yukinord red
            pink = "#b48ead",      -- yukinord purple
            mauve = "#b48ead",     -- yukinord purple
            peach = "#d08770",     -- yukinord orange (strings)
            yellow = "#ebcb8b",    -- yukinord yellow (functions, numbers)
            green = "#a3be8c",     -- yukinord green (types)
            teal = "#8fbcbb",      -- yukinord teal
            sky = "#88c0d0",       -- yukinord cyan (keywords)
            sapphire = "#5e81ac",  -- yukinord blue_bright (selection)
            blue = "#81a1c1",      -- yukinord blue (info)
            lavender = "#88c0d0",  -- yukinord cyan
            -- Foreground colors
            text = "#eceff4",      -- yukinord fg0 (bright)
            subtext1 = "#e5e9f0",  -- yukinord fg1
            subtext0 = "#d8dee9",  -- yukinord fg2 (editor foreground)
            -- Overlay colors (muted)
            overlay2 = "#8d929c",  -- yukinord fg3 (comments)
            overlay1 = "#7b8394",  -- between fg3 and fg4
            overlay0 = "#616e88",  -- yukinord fg4 (line numbers)
            -- Surface colors (backgrounds)
            surface2 = "#4c566a",  -- yukinord bg5 (button secondary)
            surface1 = "#434c5e",  -- yukinord bg4 (line highlight)
            surface0 = "#3b4252",  -- yukinord border
            -- Base backgrounds
            base = "#1B212B",      -- yukinord bg0 (editor background)
            mantle = "#14171d",    -- yukinord bg1 (panel background)
            crust = "#0f1115",     -- darker than bg1
          },
        },
        transparent_background = false,
        show_end_of_buffer = false,
        integration_default = false,
        no_bold = true,
        no_italic = true,
        no_underline = true,
        integrations = {
          blink_cmp = { style = "bordered" },
          snacks = { enabled = true },
          gitsigns = true,
          native_lsp = { enabled = true, inlay_hints = { background = true } },
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
          fidget = true,
          mason = true,
          neotest = true,
          dap_ui = true,
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

              -- Statusline (yukinord color #2B3442)
              StatusLine = { fg = colors.subtext0, bg = "#2B3442" },
              StatusLineNC = { fg = colors.subtext0, bg = "#2B3442" },

              -- Mini.statusline (all sections same yukinord color)
              MiniStatuslineModeNormal = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeInsert = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeVisual = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeReplace = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeCommand = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeOther = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineDevinfo = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineFilename = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineFileinfo = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineInactive = { fg = colors.overlay0, bg = "#2B3442" },

              -- Yukinord-style syntax highlighting
              Boolean = { fg = colors.sky },      -- cyan for booleans
              Number = { fg = colors.yellow },    -- yellow for numbers
              Float = { fg = colors.yellow },     -- yellow for floats

              PreProc = { fg = colors.sky },      -- cyan for preprocessor
              PreCondit = { fg = colors.sky },
              Include = { fg = colors.sky },
              Define = { fg = colors.sky },
              Conditional = { fg = colors.mauve }, -- purple for control flow
              Repeat = { fg = colors.mauve },
              Keyword = { fg = colors.sky },      -- cyan for keywords
              Typedef = { fg = colors.green },    -- green for types
              Exception = { fg = colors.mauve },  -- purple for exceptions
              Statement = { fg = colors.sky },    -- cyan for statements

              Error = { fg = colors.red },
              StorageClass = { fg = colors.sky }, -- cyan
              Tag = { fg = colors.sky },
              Label = { fg = colors.sky },
              Structure = { fg = colors.green },  -- green for structures
              Operator = { fg = colors.subtext0 }, -- muted operators like yukinord
              Title = { fg = colors.sky },
              Special = { fg = colors.peach },    -- orange for special
              SpecialChar = { fg = colors.yellow },
              Type = { fg = colors.green },       -- green for types (like yukinord)
              Function = { fg = colors.yellow },  -- yellow for functions (like yukinord)
              Delimiter = { fg = colors.subtext0 }, -- muted delimiters
              Ignore = { fg = colors.overlay0 },
              Macro = { fg = colors.sky },        -- cyan for macros

              -- Yukinord-style Treesitter highlights
              TSAnnotation = { fg = colors.sky },
              TSAttribute = { fg = colors.sky },
              TSBoolean = { fg = colors.sky },     -- cyan for booleans
              TSCharacter = { fg = colors.yellow },
              TSCharacterSpecial = { link = "SpecialChar" },
              TSComment = { link = "Comment" },
              TSConditional = { fg = colors.mauve }, -- purple for control
              TSConstBuiltin = { fg = colors.sky },  -- cyan for builtin constants
              TSConstMacro = { fg = colors.sky },
              TSConstant = { fg = colors.sky },      -- cyan for constants
              TSConstructor = { fg = colors.green }, -- green for constructors
              TSDebug = { link = "Debug" },
              TSDefine = { link = "Define" },
              TSEnvironment = { link = "Macro" },
              TSEnvironmentName = { link = "Type" },
              TSError = { link = "Error" },
              TSException = { fg = colors.mauve },   -- purple for exceptions
              TSField = { fg = colors.subtext0 },    -- muted for fields
              TSFloat = { fg = colors.yellow },      -- yellow for numbers
              TSFuncBuiltin = { fg = colors.yellow },
              TSFuncMacro = { fg = colors.yellow },
              TSFunction = { fg = colors.yellow },   -- yellow for functions
              TSFunctionCall = { fg = colors.yellow },
              TSInclude = { fg = colors.sky },       -- cyan for imports
              TSKeyword = { fg = colors.sky },       -- cyan for keywords
              TSKeywordFunction = { fg = colors.sky },
              TSKeywordOperator = { fg = colors.subtext0 },
              TSKeywordReturn = { fg = colors.mauve }, -- purple for return
              TSLabel = { fg = colors.sky },
              TSLiteral = { link = "String" },
              TSMath = { fg = colors.subtext0 },
              TSMethod = { fg = colors.yellow },     -- yellow for methods
              TSMethodCall = { fg = colors.yellow },
              TSNamespace = { fg = colors.green },   -- green for namespaces
              TSNone = { fg = colors.text },
              TSNumber = { fg = colors.yellow },     -- yellow for numbers
              TSOperator = { fg = colors.subtext0 }, -- muted operators
              TSParameter = { fg = colors.subtext0 }, -- muted parameters
              TSParameterReference = { fg = colors.subtext0 },
              TSPreProc = { link = "PreProc" },
              TSProperty = { fg = colors.subtext0 }, -- muted properties
              TSPunctBracket = { fg = colors.subtext0 },
              TSPunctDelimiter = { link = "Delimiter" },
              TSPunctSpecial = { fg = colors.subtext0 },
              TSRepeat = { fg = colors.mauve },      -- purple for loops
              TSStorageClass = { fg = colors.sky },
              TSStorageClassLifetime = { fg = colors.sky },
              TSStrike = { fg = colors.overlay1 },
              TSString = { fg = colors.peach },      -- orange for strings
              TSStringEscape = { fg = colors.yellow },
              TSStringRegex = { fg = colors.yellow },
              TSStringSpecial = { link = "SpecialChar" },
              TSSymbol = { fg = colors.subtext0 },
              TSTag = { fg = colors.sky },           -- cyan for tags
              TSTagAttribute = { fg = colors.subtext0 },
              TSTagDelimiter = { fg = colors.subtext0 },
              TSText = { fg = colors.subtext0 },
              TSTextReference = { link = "Constant" },
              TSTitle = { link = "Title" },
              TSTodo = { link = "Todo" },
              TSType = { fg = colors.green },        -- green for types
              TSTypeBuiltin = { fg = colors.green },
              TSTypeDefinition = { fg = colors.green },
              TSTypeQualifier = { fg = colors.sky },
              TSURI = { fg = colors.sky, underline = true },
              TSVariable = { fg = colors.subtext0 }, -- muted variables
              TSVariableBuiltin = { fg = colors.sky }, -- cyan for builtins

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
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Nordic
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        bold_keywords = false,
        italic_comments = false,
        transparent = { bg = false, float = false },
        bright_border = false,
        reduced_blue = true,
        swap_backgrounds = false,
        cursorline = {
          bold = false,
          bold_number = true,
          theme = "dark",
          blend = 0.85,
        },
        noice = { style = "flat" },
        telescope = { style = "flat" },
        leap = { dim_backdrop = false },
        ts_context = { dark_background = true },
      })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- GitHub Theme
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled",
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "NONE",
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = { match_paren = false, visual = false, search = false },
          darken = { floats = true, sidebars = { enable = true, list = {} } },
        },
      })
    end,
  },
}
