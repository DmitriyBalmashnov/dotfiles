# My simple Dotfiles

A modular, GPU-accelerated development environment themed with [Catppuccin Mocha](https://github.com/catppuccin/catppuccin). 

## Specs:

| Component | Tool | Description |
| :--- | :--- | :--- |
| **Terminal** | [KiTTY](https://sw.kovidgoyal.net/kitty/) | GPU-accelerated, fast, and highly customizable. |
| **Shell** | [Zsh](https://www.zsh.org/) | With Vi-mode, Alt-key bindings, and syntax highlighting. |
| **Prompt** | [Starship](https://starship.rs/) | Fast, context-aware prompt with custom zrok status indicators. |
| **Multiplexer** | [Tmux](https://github.com/tmux/tmux) | Session persistence and advanced pane management. |
| **Editor** | [Neovim](https://neovim.io/) | Lua-based configuration focused on LSP and performance. |
| **Theme** | [Catppuccin](https://github.com/catppuccin/catppuccin) | Soothing pastel theme for high-focus work. |

## Quick Start

### 1. Prerequisites
Ensure you have the following installed on your system:
- `zsh`, `tmux`, `neovim`, `kitty`
- [Starship](https://starship.rs/install.sh)
- [GNU Stow](https://www.gnu.org/software/stow/)
- A [Nerd Font](https://www.nerdfonts.com/) (e.g., JetBrainsMono Nerd Font) installed in KiTTY.

### 2. Installation
Clone the repository and use Stow to symlink the configurations:

```bash
git clone https://github.com/DmitryBalmashno/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install TPM (Tmux Plugin Manager)
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Deploy modules (uses --no-folding for sensitive directories)
stow zsh starship nvim
stow --no-folding kitty tmux
```
