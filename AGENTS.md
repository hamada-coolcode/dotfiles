# AGENTS.md - Dotfiles Repository

## Overview

This is a dotfiles repository managed by **GNU stow**. Each subdirectory represents a stow package containing configuration files that will be symlinked to `$HOME`.

## Repository Structure

```
dotfiles/
├── bat/          # bat config
├── btop/         # btop config  
├── fish/         # fish shell config
├── glow/         # glow config
├── helix/        # helix editor config
├── JetBrains/    # JetBrains IDEs config
├── opencode/     # opencode config
├── yazi/         # yazi file manager config
├── zed/          # zed editor config
├── zellij/       # zellij terminal multiplexer config
└── new_config.sh # Utility script for adding new dotfiles
```

## Build/Lint/Test Commands

### GNU Stow Commands

```bash
# Stow all packages (creates symlinks in $HOME)
stow */

# Stow a specific package
stow nvim

# Delete stowed symlinks (unlink from $HOME)
stow -D nvim

# Restow (delete and recreate symlinks)
stow -R nvim

# Stow to a different target (useful for testing)
stow -t=/some/path nvim
```

### Shell Script Linting

```bash
# Lint a shell script
shellcheck new_config.sh
```

### Testing Dotfiles Changes

```bash
# Preview what stow will do without making changes
stow -nvt ~ */

# Stow to a test directory first
mkdir -p /tmp/test-home
stow -t /tmp/test-home -S */
```

## Code Style Guidelines

### Shell Scripts (new_config.sh)

- Use `#!/bin/bash` shebang (not `#!/bin/sh`)
- Use `[[ ]]` for conditionals (not `[ ]`)
- Always quote variables: `"$variable"` not `$variable`
- Use `$()` for command substitution, not backticks
- Add error handling with `set -euo pipefail`
- Always reference variables with `$` (e.g., `$root` not `root`)

### Configuration Files

- Use standard config formats: TOML, JSON, YAML, or shell formats
- Keep configs organized and commented
- Use consistent indentation (2 or 4 spaces per convention)
- For TOML: use lowercase with underscores
- For JSON: use camelCase or snake_case consistently

### Dotfile Organization

- Each stow package should be in its own directory
- The directory name matches the tool name (e.g., `bat/`, `helix/`)
- Config paths inside packages should be relative to `$HOME`
- Example: `bat/.config/bat/config` stows to `$HOME/.config/bat/config`

## Using new_config.sh

```bash
# Basic usage - moves config to stow structure
./new_config.sh <package_name> <config_path>

# Example: add nvim config
./new_config.sh nvim .config/nvim

# With --root flag (stows to / instead of ~)
./new_config.sh nvim .config/nvim --root
./new_config.sh nvim .config/nvim -r
```

## Adding New Dotfiles

1. Use `new_config.sh` or manually create the directory structure
2. Ensure the path inside the package mirrors the destination in `$HOME`
3. Run `stow <package_name>` to create symlinks
4. Test that the application reads the config correctly

## Common Workflows

### Initial Setup
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow */
```

### Updating an Existing Config
```bash
vim bat/.config/bat/config
git add bat/.config/bat/config
git commit -m "Update bat config"
```

### Adding a New Tool Config
```bash
./new_config.sh zsh .zshrc
# or
mkdir -p zsh && mv ~/.zshrc ./zsh/ && stow zsh
```

### Removing a Stowed Package
```bash
stow -D package_name
rm -rf package_name/
```

## Troubleshooting

### Symlink Already Exists
```bash
stow -nvt ~ package_name  # check what's conflicting
stow --adopt package_name  # careful - overwrites existing!
```

### Symlink Points to Wrong Location
```bash
stow -R package_name  # restow to fix
```

### Package Not Stowing
```bash
ls -la package_name/  # ensure package isn't empty
```

## Error Handling in Shell Scripts

```bash
#!/bin/bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <package_name> <config_path>" >&2
  exit 1
fi

local var="${1:-default}"
```

## Config File Guidelines

### TOML Files (Helix, Glow)
- Use lowercase with underscores: `key_name = value`
- Tables use brackets: `[section]`
- Comments start with `#`

### JSON Files (Zed)
- Use camelCase or snake_case consistently
- No trailing commas

## Important Notes

- Do not commit sensitive data (API keys, passwords, tokens)
- Review stow output to ensure symlinks are created correctly
