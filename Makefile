.PHONY: help setup update install-tools link verify clean

DOTFILES := $(HOME)/dotfiles
TOOLS := $(DOTFILES)/tools

help:
	@echo "Dotfiles Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  setup          - Run initial setup (symlink + install tools)"
	@echo "  link          - Symlink config files to home"
	@echo "  install-tools - Install CLI tools (fzf, bat, ripgrep, lazygit)"
	@echo "  update        - Update all tools (neovim, lazygit, kitty, tmux)"
	@echo "  verify        - Verify configs are properly linked"
	@echo "  clean         - Remove backup files"

setup: link install-tools
	@echo "Setup complete! Restart your shell."

link:
	@echo "Symlinking config files..."
	@ln -sf $(DOTFILES)/.bash_aliases $(HOME)/.bash_aliases
	@ln -sf $(DOTFILES)/.tmux.conf $(HOME)/.tmux.conf
	@rm -rf $(HOME)/.config/fish && ln -sf $(DOTFILES)/fish $(HOME)/.config/fish
	@rm -rf $(HOME)/.config/nvim && ln -sf $(DOTFILES)/nvim $(HOME)/.config/nvim
	@rm -rf $(HOME)/.config/kitty && ln -sf $(DOTFILES)/kitty $(HOME)/.config/kitty
	@rm -rf $(HOME)/.config/lazygit && ln -sf $(DOTFILES)/lazygit $(HOME)/.config/lazygit
	@echo "Symlinks created."

install-tools:
	@echo "Installing tools..."
	@$(TOOLS)/setup.sh 2>/dev/null || echo "Run tools/setup.sh manually"

update:
	@echo "Updating tools..."
	@$(TOOLS)/update-neovim.sh || true
	@$(TOOLS)/update-lazygit.sh || true
	@$(TOOLS)/update-kitty.sh || true
	@$(TOOLS)/update-tmux.sh || true
	@echo "Update complete."

verify:
	@echo "Verifying symlinks..."
	@@test -L $(HOME)/.bash_aliases && echo "✓ .bash_aliases" || echo "✗ .bash_aliases missing - run 'make link'"
	@@test -L $(HOME)/.tmux.conf && echo "✓ .tmux.conf" || echo "✗ .tmux.conf missing - run 'make link'"
	@@test -L $(HOME)/.config/fish && echo "✓ fish" || echo "✗ fish missing - run 'make link'"
	@@test -L $(HOME)/.config/nvim && echo "✓ nvim" || echo "✗ nvim missing - run 'make link'"
	@@test -L $(HOME)/.config/kitty && echo "✓ kitty" || echo "✗ kitty missing - run 'make link'"
	@@test -L $(HOME)/.config/lazygit && echo "✓ lazygit" || echo "✗ lazygit missing - run 'make link'"

clean:
	@echo "Cleaning up..."
	@rm -rf $(DOTFILES)/backup
	@echo "Done."