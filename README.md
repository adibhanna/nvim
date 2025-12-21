# Neovim Configuration

A modern Neovim configuration for Neovim 0.11+ with lazy-loading, LSP support, and a clean keybinding structure.

## Requirements

### System Dependencies

Install via Homebrew:

```bash
# Required
brew install neovim ripgrep fd git

# For Git integration
brew install lazygit

# For Snacks.image (optional - inline images)
brew install imagemagick ghostscript

# For LaTeX/Mermaid rendering (optional)
brew install tectonic mermaid-cli
```

### Rust (for tree-sitter-cli)

The config auto-installs `tree-sitter-cli` via cargo if not present:

```bash
# Install Rust if not already installed
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone <your-repo> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (loads core/)
├── lua/
│   ├── core/                   # Core configuration
│   │   ├── init.lua            # Loads all core modules
│   │   ├── options.lua         # Neovim options
│   │   ├── keymaps.lua         # Core keymaps
│   │   ├── autocmds.lua        # Auto commands
│   │   ├── lazy.lua            # Plugin manager bootstrap
│   │   └── utils.lua           # Utility functions
│   └── plugins/                # Plugin configurations
│       ├── ai.lua              # Claude AI integration
│       ├── coding.lua          # Completion, treesitter, snippets
│       ├── colorschemes.lua    # Color themes
│       ├── dap.lua             # Debugging
│       ├── devplugins.lua      # Custom plugin development
│       ├── editor.lua          # Flash, mini, persistence, spectre
│       ├── formatting.lua      # Conform.nvim
│       ├── git.lua             # Git integration
│       ├── linting.lua         # nvim-lint
│       ├── lsp.lua             # LSP configuration
│       ├── snacks.lua          # UI utilities and pickers
│       ├── tools.lua           # Notes, file creation
│       └── ui.lua              # Which-key, diagnostics, trouble
```

## Keybindings

Leader key: `<Space>`

### Quick Access (Top-level)

| Key | Description |
|-----|-------------|
| `<leader><space>` | Smart find (files/buffers) |
| `<leader>/` | Grep in project |
| `<leader>:` | Command history |
| `<leader>e` | File explorer |
| `<leader>z` | Zen mode |
| `<leader>Z` | Zoom current window |
| `<leader>.` | Scratch buffer |
| `<leader>n` | Notification history |
| `<leader>N` | Neovim news |
| `<leader>v` | Definition in vertical split |
| `<leader>?` | Buffer keymaps |
| `<C-/>` | Terminal |
| `Q` | Delete buffer |

### AI (`<leader>a`)

| Key | Description |
|-----|-------------|
| `<leader>aa` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume session |
| `<leader>ac` | Continue session |
| `<leader>am` | Select model |
| `<leader>ab` | Add buffer to context |
| `<leader>as` | Send selection (visual) |
| `<leader>at` | Add file from tree |
| `<leader>ay` | Accept diff |
| `<leader>an` | Deny diff |

### Buffers (`<leader>b`)

| Key | Description |
|-----|-------------|
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |

### Code (`<leader>c`)

| Key | Description |
|-----|-------------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cR` | Rename file |
| `<leader>cd` | Line diagnostic |
| `<leader>cf` | Format |

### Diagnostics/Debug (`<leader>d`)

| Key | Description |
|-----|-------------|
| `<leader>dd` | Workspace diagnostics |
| `<leader>dD` | Buffer diagnostics |
| `<leader>dt` | Trouble (workspace) |
| `<leader>dT` | Trouble (buffer) |
| `<leader>dq` | Quickfix list |
| `<leader>dl` | Location list |
| `<leader>dL` | Trouble location list |
| `<leader>dQ` | Trouble quickfix |
| `<leader>dc` | Debug: Continue |
| `<leader>db` | Debug: Breakpoint |
| `<leader>dB` | Debug: Conditional breakpoint |
| `<leader>di` | Debug: Step into |
| `<leader>do` | Debug: Step over |
| `<leader>dO` | Debug: Step out |
| `<leader>dr` | Debug: Run last |
| `<leader>du` | Debug: Toggle UI |

### Find/Files (`<leader>f`)

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Config files |
| `<leader>fg` | Git files |
| `<leader>fp` | Projects |

### Git (`<leader>g`)

| Key | Description |
|-----|-------------|
| `<leader>gg` | Lazygit |
| `<leader>gb` | Branches |
| `<leader>gl` | Log |
| `<leader>gL` | Log (line) |
| `<leader>gf` | Log (file) |
| `<leader>gs` | Status |
| `<leader>gS` | Stash |
| `<leader>gd` | Diff |
| `<leader>gD` | Diff HEAD |
| `<leader>gB` | Browse on GitHub |
| `<leader>gi` | Issues |
| `<leader>gI` | Issues (all) |
| `<leader>gp` | Pull requests |
| `<leader>gP` | Pull requests (all) |
| `<leader>gh` | Preview hunk |
| `<leader>gH` | Preview hunk inline |
| `<leader>ga` | Stage hunk |
| `<leader>gu` | Undo stage |
| `<leader>gr` | Reset hunk |
| `<leader>gR` | Reset buffer |
| `<leader>gx` | Blame line |

### LSP (`<leader>l`)

| Key | Description |
|-----|-------------|
| `<leader>li` | LSP info |
| `<leader>lr` | LSP restart |
| `<leader>lh` | Toggle inlay hints |
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>lt` | LSP references (Trouble) |
| `<leader>lT` | Symbols (Trouble) |
| `<leader>ll` | Run linter |
| `<leader>lI` | Lint info |
| `<leader>lL` | Toggle lint |
| `<leader>lC` | Clear lint |

### Search (`<leader>s`)

| Key | Description |
|-----|-------------|
| `<leader>ss` | Grep |
| `<leader>sw` | Search word under cursor |
| `<leader>sb` | Buffer lines |
| `<leader>sB` | Grep open buffers |
| `<leader>sh` | Help tags |
| `<leader>sm` | Marks |
| `<leader>sj` | Jumps |
| `<leader>sk` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>sC` | Command history |
| `<leader>s/` | Search history |
| `<leader>sr` | Registers |
| `<leader>sa` | Autocmds |
| `<leader>sH` | Highlights |
| `<leader>si` | Icons |
| `<leader>sM` | Man pages |
| `<leader>sp` | Plugins |
| `<leader>sn` | Notifications |
| `<leader>su` | Undo history |
| `<leader>sR` | Resume last search |
| `<leader>sS` | Search & replace (Spectre) |
| `<leader>sW` | Replace word (Spectre) |
| `<leader>sF` | Replace in file (Spectre) |

### UI/Toggles (`<leader>u`)

| Key | Description |
|-----|-------------|
| `<leader>uC` | Colorschemes |
| `<leader>un` | Dismiss notifications |
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle wrap |
| `<leader>ur` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers |
| `<leader>uD` | Toggle diagnostics |
| `<leader>uc` | Toggle conceal |
| `<leader>uT` | Toggle treesitter |
| `<leader>ub` | Toggle dark/light |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ui` | Toggle indent guides |
| `<leader>ud` | Toggle dim |
| `<leader>uU` | Undo tree |

### Windows (`<leader>w`)

| Key | Description |
|-----|-------------|
| `<leader>wd` | Close window |
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical |
| `<leader>wh` | Go left |
| `<leader>wj` | Go down |
| `<leader>wk` | Go up |
| `<leader>wl` | Go right |
| `<leader>ww` | Other window |
| `<leader>w=` | Equal size |

### Navigation

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gi` | Go to implementation (LSP) |
| `gt` | Go to type definition (LSP) |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `]h` | Next git hunk |
| `[h` | Previous git hunk |
| `]]` | Next reference |
| `[[` | Previous reference |

### Editing

| Key | Mode | Description |
|-----|------|-------------|
| `J` | Visual | Move lines down |
| `K` | Visual | Move lines up |
| `<` | Visual | Indent left (stay selected) |
| `>` | Visual | Indent right (stay selected) |
| `p` | Visual | Paste without yanking |
| `H` | Normal | Start of line |
| `L` | Normal | End of line |
| `X` | Normal | Split line |
| `YY` | Normal | Yank block {} |
| `jj` / `jk` | Insert | Exit insert mode |
| `<C-x>` | Normal | Cut line |
| `<C-a>` | Normal | Select all |
| `<C-n>` | Normal | Write new file |
| `<C-P>` | Normal | Toggle Go test file |
| `<C-s>` | Normal | Grep buffers |
| `<Esc>` | Normal | Clear search highlight |
| `+` / `_` | Normal | Resize width |
| `=` / `-` | Normal | Resize height |
| `<Left>` / `<Right>` | Normal | Navigate buffers |
| `n` / `N` | Normal | Next/prev match (centered) |

### Flash (Motion)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n/x/o | Flash jump |
| `S` | n/x/o | Flash treesitter |
| `r` | o | Remote flash |
| `R` | o/x | Treesitter search |
| `<C-s>` | c | Toggle flash search |

### Mini.surround

| Key | Description |
|-----|-------------|
| `sa` | Add surrounding |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |
| `sf` | Find surrounding (right) |
| `sF` | Find surrounding (left) |
| `sh` | Highlight surrounding |

## Language Servers

Auto-installed via Mason:

- **Lua**: lua_ls
- **Go**: gopls
- **TypeScript/JavaScript**: ts_ls
- **Rust**: rust-analyzer
- **Python**: pyright
- **PHP**: intelephense
- **Zig**: zls
- **Bash**: bashls
- **CSS**: cssls
- **HTML**: html
- **JSON**: jsonls
- **YAML**: yamlls

## Formatters

Configured in `formatting.lua`:

| Language | Formatter |
|----------|-----------|
| Go | goimports, gofmt |
| Lua | stylua |
| JavaScript/TypeScript | prettier |
| JSON/YAML/HTML/CSS | prettier |
| Python | isort, black |
| PHP | pint |
| Shell | shfmt |
| Rust | rustfmt |

## Linters

Configured in `linting.lua`:

| Language | Linter |
|----------|--------|
| Go | golangci-lint |
| JavaScript/TypeScript | eslint_d |
| Lua | luacheck |
| Python | ruff, mypy |
| PHP | phpstan |
| Shell | shellcheck |
| YAML | yamllint |
| JSON | jsonlint |
| Markdown | markdownlint |
| HTML | htmlhint |
| CSS | stylelint |

## Health Check

Run `:checkhealth` to verify your setup. Common issues:

- **Missing CLI tools**: Install via `brew install <tool>`
- **Provider warnings**: Already disabled in config
- **Treesitter errors**: Run `:TSUpdate`

## Colorscheme

Default: `yukinord`

Available (toggle with `<leader>uC`):
- yukinord
- gruvbox-material
- catppuccin
- nordic
- github-theme
- forest-night

---

Always a WIP.
