# Neovim Configuration

A minimal, fast Neovim configuration for Neovim 0.11+ with lazy-loading, LSP support, and intuitive keybindings.

---

## Installation

### 1. System Dependencies (Required)

```bash
# Core requirements
brew install neovim    # v0.11+ required
brew install git
brew install ripgrep   # Fast grep (used by picker)
brew install fd        # Fast find (used by picker)
brew install lazygit   # Git TUI
brew install node      # Required for some LSPs and tools
brew install npm       # Required for markdown-preview
```

### 2. Fonts (Required)

Install a [Nerd Font](https://www.nerdfonts.com/) for icons:

```bash
brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-fira-code-nerd-font
```

Then set your terminal to use the installed font.

### 3. Language Toolchains (Install what you need)

```bash
# Go
brew install go
# After install, run :GoInstallBinaries in nvim

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# After install, run :CargoInstallTools in nvim

# Zig
brew install zig

# Python
brew install python
pip install pynvim  # Optional: for some plugins

# PHP
brew install php composer

# Lua (for luarocks, optional)
brew install lua luarocks
```

### 4. Optional Dependencies

```bash
# Markdown preview (browser-based)
# markdown-preview.nvim will auto-install, but needs npm

# Image rendering (optional)
brew install imagemagick ghostscript

# Mermaid diagrams (optional)
npm install -g @mermaid-js/mermaid-cli

# LaTeX rendering (optional)
brew install tectonic
```

### 5. Clone and Start

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone this config
git clone <your-repo> ~/.config/nvim

# Start Neovim - plugins will auto-install on first launch
nvim
```

### 6. Post-Install Steps

Run these commands in Neovim after first launch:

```vim
" Wait for lazy.nvim to finish installing plugins, then:

" Generate help tags
:helptags ALL

" Install treesitter parsers (auto-installs, but can force)
:TSUpdate

" Check health
:checkhealth

" For Go development
:GoInstallBinaries

" For Rust development  
:CargoInstallTools

" Build markdown-preview (if not auto-built)
:Lazy build markdown-preview.nvim
```

### Verify Installation

```vim
:checkhealth
```

All checks should pass. Common fixes:
- Missing CLI tools: `brew install <tool>`
- Treesitter errors: `:TSUpdate`
- LSP not working: `:LspInfo` and `:Mason`

---

## What Gets Auto-Installed

### Via Mason (LSP/Linters/Formatters)

| Category | Tools |
|----------|-------|
| **LSP Servers** | lua_ls, gopls, zls, ts_ls, rust-analyzer, intelephense, bashls, pyright, cssls, html, jsonls, yamlls |
| **Linters** | eslint_d, luacheck, golangci-lint, shellcheck, markdownlint, yamllint, jsonlint, htmlhint, stylelint, phpstan, ruff, mypy |
| **Formatters** | stylua, goimports, prettier, black, isort, shfmt, pint |

### Via Treesitter

Parsers for: bash, c, css, go, html, javascript, json, latex, lua, markdown, php, python, rust, scss, svelte, terraform, tsx, typescript, vim, vue, yaml, zig

---

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua         # Loads all core modules
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Core keybindings
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── lazy.lua         # Plugin manager bootstrap
│   │   └── utils.lua        # Utility functions
│   └── plugins/
│       ├── coding.lua       # Completion, treesitter
│       ├── colorschemes.lua # Themes
│       ├── editor.lua       # Flash, mini.nvim, persistence
│       ├── formatting.lua   # Conform.nvim (format on save)
│       ├── git.lua          # Gitsigns, fugitive, diffview
│       ├── linting.lua      # nvim-lint
│       ├── lsp.lua          # LSP + Mason
│       ├── snacks.lua       # Picker, explorer, notifications
│       ├── tools.lua        # Notes, file creation
│       └── ui.lua           # Which-key, trouble, markdown
├── ftplugin/
│   ├── go.lua               # Go commands (:GoTest, :GoBuild, etc.)
│   ├── rust.lua             # Rust commands (:CargoRun, :CargoTest, etc.)
│   └── zig.lua              # Zig commands (:ZigBuild, :ZigTest, etc.)
└── doc/
    ├── go.txt               # :help go.txt
    ├── rust.txt             # :help rust.txt
    └── zig.txt              # :help zig.txt
```

---

## Keybindings

**Leader key:** `<Space>`

### Essential (No Prefix)

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<Esc>` | Clear search highlight |
| `jj` / `jk` | Exit insert mode |
| `H` / `L` | Start/End of line |
| `<S-h>` / `<S-l>` | Prev/Next buffer |
| `Q` | Delete buffer |
| `K` | Hover documentation |
| `s` | Flash jump |
| `S` | Flash treesitter |

### Quick Access (Leader)

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>/` | Grep |
| `<leader>,` | Switch buffer |
| `<leader>.` | Scratch buffer |
| `<leader>e` | File explorer |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all |
| `<leader>?` | Buffer keymaps |
| `<leader>K` | All keymaps |
| `<C-/>` | Terminal |

### Buffers (`<leader>b`)

| Key | Action |
|-----|--------|
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |

### Code (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostic |
| `<leader>cf` | Format |
| `<leader>cv` | Definition in vsplit |

### Diagnostics (`<leader>d`)

| Key | Action |
|-----|--------|
| `<leader>dd` | Workspace diagnostics |
| `<leader>db` | Buffer diagnostics |
| `<leader>dt` | Trouble (workspace) |
| `<leader>dT` | Trouble (buffer) |
| `<leader>dq` | Quickfix list |
| `<leader>dl` | Location list |

### Files (`<leader>f`)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Config files |
| `<leader>fg` | Git files |
| `<leader>fp` | Projects |
| `<leader>fR` | Rename file |

### Git (`<leader>g`)

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Status |
| `<leader>gl` | Log |
| `<leader>gL` | Log (line) |
| `<leader>gf` | Log (file) |
| `<leader>gd` | Diff (picker) |
| `<leader>gD` | Diff HEAD |
| `<leader>gc` | Checkout branch |
| `<leader>go` | Open in browser |
| `<leader>gb` | Blame line |
| `<leader>gB` | Blame buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gS` | Stage buffer |
| `<leader>gi` | GitHub issues |
| `<leader>gp` | GitHub PRs |

### Git Hunks (`<leader>gh`)

| Key | Action |
|-----|--------|
| `<leader>ghp` | Preview hunk |
| `<leader>ghP` | Preview hunk inline |
| `<leader>ghs` | Stage hunk |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghr` | Reset hunk |
| `]h` / `[h` | Next/Prev hunk |

### LSP (`<leader>l`)

| Key | Action |
|-----|--------|
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>li` | LSP info |
| `<leader>lr` | LSP restart |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lt` | References (Trouble) |
| `<leader>lT` | Symbols (Trouble) |

### Markdown (`<leader>m`)

| Key | Action |
|-----|--------|
| `<leader>mp` | Preview in browser |
| `<leader>mr` | Toggle render in buffer |

### Notifications (`<leader>n`)

| Key | Action |
|-----|--------|
| `<leader>nn` | Notification history |
| `<leader>nd` | Dismiss all |

### Search (`<leader>s`)

| Key | Action |
|-----|--------|
| `<leader>sg` | Grep |
| `<leader>sw` | Word under cursor |
| `<leader>sb` | Buffer lines |
| `<leader>sB` | Grep buffers |
| `<leader>sh` | Help |
| `<leader>sm` | Marks |
| `<leader>sj` | Jumps |
| `<leader>sk` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>s:` | Command history |
| `<leader>s/` | Search history |
| `<leader>sr` | Registers |
| `<leader>sR` | Resume last |
| `<leader>su` | Undo history |

### UI/Toggles (`<leader>u`)

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle wrap |
| `<leader>ur` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers |
| `<leader>uD` | Toggle diagnostics |
| `<leader>uc` | Toggle conceal |
| `<leader>uT` | Toggle treesitter |
| `<leader>ub` | Toggle background |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ui` | Toggle indent guides |
| `<leader>ud` | Toggle dim |
| `<leader>uC` | Colorschemes |
| `<leader>uz` | Zen mode |
| `<leader>uZ` | Zoom |

### Windows (`<leader>w`)

| Key | Action |
|-----|--------|
| `<leader>wd` | Close window |
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical |
| `<leader>ww` | Other window |
| `<leader>w=` | Equal size |
| `<leader>wm` | Maximize |

### Goto (`g`)

| Key | Action |
|-----|--------|
| `gd` | Definition |
| `gD` | Declaration |
| `gr` | References |
| `gi` | Implementation |
| `gy` | Type definition |

### Navigation (`[` / `]`)

| Key | Action |
|-----|--------|
| `[d` / `]d` | Prev/Next diagnostic |
| `[h` / `]h` | Prev/Next hunk |
| `[b` / `]b` | Prev/Next buffer |
| `[[` / `]]` | Prev/Next reference |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `J` / `K` | Visual | Move lines down/up |
| `<` / `>` | Visual | Indent (stay selected) |
| `p` | Visual | Paste (no yank) |
| `X` | Normal | Split line |
| `YY` | Normal | Yank block {} |
| `n` / `N` | Normal | Next/Prev match (centered) |

### Surround (mini.surround)

| Key | Action |
|-----|--------|
| `gsa` | Add surrounding |
| `gsd` | Delete surrounding |
| `gsr` | Replace surrounding |
| `gsf` | Find surrounding (right) |
| `gsF` | Find surrounding (left) |

---

## Language-Specific Commands

### Go (`:help go.txt`)

| Command | Action |
|---------|--------|
| `:GoBuild` | go build |
| `:GoRun` | go run |
| `:GoTest` | go test |
| `:GoTestFunc` | Test function under cursor |
| `:GoTestFile` | Test current package |
| `:GoCoverage` | Test with coverage |
| `:GoModTidy` | go mod tidy |
| `:GoGet <pkg>` | go get |
| `:GoVet` | go vet |
| `:GoLint` | golangci-lint |
| `:GoDoc <sym>` | go doc |
| `:GoImpl` | Generate interface stubs |
| `:GoIfErr` | Insert if err != nil |
| `:GoAddTags` | Add struct tags |
| `:GoAlt` | Switch test/source |
| `:GoInstallBinaries` | Install all Go tools |

### Rust (`:help rust.txt`)

| Command | Action |
|---------|--------|
| `:CargoBuild` | cargo build |
| `:CargoBuildRelease` | cargo build --release |
| `:CargoRun` | cargo run |
| `:CargoTest` | cargo test |
| `:CargoTestFunc` | Test function under cursor |
| `:CargoCheck` | cargo check |
| `:CargoClippy` | cargo clippy |
| `:CargoFmt` | cargo fmt |
| `:CargoAdd <crate>` | cargo add |
| `:CargoDoc` | cargo doc |
| `:RustDoc <crate>` | Open docs.rs |
| `:CargoInstallTools` | Install cargo subcommands |

### Zig (`:help zig.txt`)

| Command | Action |
|---------|--------|
| `:ZigBuild` | zig build |
| `:ZigBuildRelease` | zig build -Doptimize=ReleaseFast |
| `:ZigRun` | zig build run |
| `:ZigRunFile` | zig run <current file> |
| `:ZigTest` | zig build test |
| `:ZigTestFile` | zig test <current file> |
| `:ZigFmt` | zig fmt |
| `:ZigDoc` | Open Zig docs |
| `:ZigAlt` | Switch test/source |

---

## Language Servers (Mason)

Auto-installed:
- **Go:** gopls
- **Rust:** rust-analyzer
- **Zig:** zls
- **Lua:** lua_ls
- **TypeScript:** ts_ls
- **Python:** pyright
- **PHP:** intelephense
- **Bash:** bashls
- **CSS/HTML/JSON/YAML:** vscode servers

## Formatters (Conform)

| Language | Formatter |
|----------|-----------|
| Go | goimports, gofmt |
| Rust | rustfmt |
| Zig | zigfmt |
| Lua | stylua |
| JS/TS/JSON/YAML/HTML/CSS | prettier |
| Python | isort, black |
| PHP | pint |
| Shell | shfmt |

Format on save is **enabled by default**.

## Linters (nvim-lint)

| Language | Linter |
|----------|--------|
| Go | golangci-lint |
| JS/TS | eslint_d |
| Lua | luacheck |
| Python | ruff, mypy |
| PHP | phpstan |
| Shell | shellcheck |

---

## Health Check

```vim
:checkhealth
```

Common fixes:
- Missing tools: `brew install <tool>`
- Treesitter errors: `:TSUpdate`
- Go tools: `:GoInstallBinaries`
- Rust tools: `:CargoInstallTools`

## Colorscheme

Default: `yukinord`

Switch with `<leader>uC`

---

Always a WIP.
