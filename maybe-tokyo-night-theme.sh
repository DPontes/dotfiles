#!/bin/bash

echo "🌙 Tokyo Night Terminal Theme Installer"
echo "======================================="

# Get the default profile UUID
PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')

if [ -z "$PROFILE" ]; then
    echo "❌ Could not find default terminal profile"
    exit 1
fi

echo "📋 Found profile: $PROFILE"

# Tokyo Night color scheme
BACKGROUND="#1a1b26"
FOREGROUND="#c0caf5"
CURSOR="#c0caf5"

# Color palette (16 colors)
PALETTE="['#15161e', '#f7768e', '#9ece6a', '#e0af68', '#7aa2f7', '#bb9af7', '#7dcfff', '#a9b1d6', '#414868', '#f7768e', '#9ece6a', '#e0af68', '#7aa2f7', '#bb9af7', '#7dcfff', '#c0caf5']"

echo "🎨 Applying Tokyo Night theme..."

# Apply the theme
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ background-color "$BACKGROUND"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ foreground-color "$FOREGROUND"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ cursor-colors-set true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ cursor-background-color "$CURSOR"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ cursor-foreground-color "$BACKGROUND"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ palette "$PALETTE"

echo "✅ Tokyo Night theme applied successfully!"
echo "🔄 Please restart your terminal or open a new tab to see the changes."

# Optional: Show current settings
echo ""
echo "📊 Current theme settings:"
echo "Background: $(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ background-color)"
echo "Foreground: $(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ foreground-color)"
echo "Using theme colors: $(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-theme-colors)"

