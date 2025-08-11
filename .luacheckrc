-- Luacheck configuration for Neovim
globals = {
    "vim", -- Neovim global
}

-- Ignore line length warnings
max_line_length = false

-- Ignore unused arguments warnings for common patterns
ignore = {
    "631", -- Line too long
    "212", -- Unused argument
    "213", -- Unused loop variable
}

-- Read-only globals
read_globals = {
    "vim",
}

-- Specific rules for test files
files["*_spec.lua"] = {
    std = "+busted",
}

-- Don't report unused self arguments of methods
self = false
