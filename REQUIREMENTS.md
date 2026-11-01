# Requirements — Arch Linux + i3 Catppuccin Mocha rice

Target: Arch Linux, i3-wm, X11 (SDDM), running in VirtualBox. Shell is bash (no zsh).
Everything comes from the official repos — **no AUR**.

## 1. Packages (pacman)

```bash
sudo pacman -S --needed \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  polybar rofi dunst libnotify feh i3lock picom \
  papirus-icon-theme lxappearance kvantum qt5ct \
  maim xclip xdotool playerctl pavucontrol network-manager-applet \
  btop fastfetch git curl unzip \
  thunar gvfs thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer xarchiver xdg-user-dirs \
  firefox \
  virtualbox-guest-utils
```

Drop `virtualbox-guest-utils` on real hardware. On a fresh system also add `i3-wm alacritty xss-lock libpulse`
(already present on the original machine, together with `pipewire-pulse`, `networkmanager`, `sddm`, `python`).

| Package | Purpose |
|---|---|
| `ttf-jetbrains-mono-nerd` | JetBrains Mono Nerd Font (system-wide default font + icons) |
| `noto-fonts`, `noto-fonts-emoji` | Fallback glyphs and emoji |
| `polybar` | Top status bar |
| `rofi` | App launcher, window switcher, power menu |
| `dunst`, `libnotify` | Notification daemon + `notify-send` |
| `feh` | Wallpaper setter |
| `i3lock` | Screen locker |
| `picom` | Compositor (xrender + vsync only, no effects — VirtualBox safe) |
| `papirus-icon-theme` | Papirus-Dark icons |
| `lxappearance` | GTK theme GUI (optional tweaking) |
| `kvantum`, `qt5ct` | Qt theming |
| `maim`, `xclip`, `xdotool` | Screenshots to file + clipboard |
| `playerctl` | Media keys |
| `pavucontrol` | Volume mixer (right-click polybar volume) |
| `network-manager-applet` | Network tray icon |
| `btop` | System monitor (Mocha theme) |
| `fastfetch` | System info |
| `git`, `curl`, `unzip` | Downloading themes / installer |
| `thunar` | File manager (Super+Shift+F), themed via the Catppuccin GTK theme |
| `gvfs` | Trash, removable drives and network locations in Thunar |
| `thunar-archive-plugin`, `xarchiver` | "Extract here" / "Create archive" in the right-click menu |
| `thunar-volman` | Auto-handling of USB drives |
| `tumbler`, `ffmpegthumbnailer` | Image / video thumbnails |
| `xdg-user-dirs` | Creates Documents, Downloads, Music, … folders |
| `firefox` | Browser. It has no config of its own here and takes its font and dark theme from the system (see below) |
| `virtualbox-guest-utils` | Auto-resize, shared clipboard in VirtualBox |

## 2. Services

```bash
sudo systemctl enable --now vboxservice
```

## 3. Installed via installer script / downloads (non-pacman)

### Oh My Posh (not in official repos — official installer, user-local, no root)

```bash
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
```

`~/.local/bin` must be on `PATH` (handled in `.bashrc` and `.xprofile`).

### Catppuccin GTK theme (official GitHub release)

```bash
mkdir -p ~/.themes /tmp/ctp && cd /tmp/ctp
curl -fsSL -o gtk.zip "https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-mauve-standard+default.zip"
unzip -q gtk.zip && cp -r "catppuccin-mocha-mauve-standard+default" ~/.themes/

# GTK4 / libadwaita apps
T=~/.themes/catppuccin-mocha-mauve-standard+default
mkdir -p ~/.config/gtk-4.0
ln -sfn $T/gtk-4.0/assets       ~/.config/gtk-4.0/assets
ln -sf  $T/gtk-4.0/gtk.css      ~/.config/gtk-4.0/gtk.css
ln -sf  $T/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
```

### Catppuccin Kvantum theme (official GitHub repo)

```bash
cd /tmp/ctp
curl -fsSL -o kv.tar.gz "https://github.com/catppuccin/Kvantum/archive/refs/heads/main.tar.gz"
tar xzf kv.tar.gz && cp -r kvantum-main/themes/catppuccin-mocha-mauve ~/.config/Kvantum/
```

(Both theme folders are also vendored in this repo under `home/.themes/` and `home/.config/Kvantum/`.)

### GNOME/GTK settings (gsettings)

```bash
gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-mauve-standard+default'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 10'
```

### Font cache

```bash
fc-cache -f
```

### Firefox

Nothing to install or copy beyond the `firefox` package. Firefox picks up the rice from two system-wide settings:

- **Font:** its default fonts are the generic `sans-serif`, `serif` and `monospace` families, which
  `~/.config/fontconfig/fonts.conf` maps to JetBrainsMono Nerd Font. Sites that load their own web fonts keep them.
  **Editing `fonts.conf` changes Firefox too.**
- **Catppuccin UI:** Firefox's built-in **"System theme — auto"** (the default,
  `extensions.activeThemeID = default-theme@mozilla.org`) draws the toolbar, tabs and menus with the GTK theme,
  which is Catppuccin Mocha Mauve. No Firefox add-on is used. `color-scheme 'prefer-dark'` (gsettings above)
  makes sites that have a dark mode use it.
  If you pick another theme in Firefox (Settings → Extensions & Themes), the Catppuccin look goes away.

The profile is in `~/.config/mozilla/firefox/` on current Firefox (`~/.mozilla/firefox/` on older versions).

Restart Firefox after changing either setting. If a Firefox profile sets its own fonts
(Settings → Fonts → Advanced), those win over fontconfig.

Optional alternative: the official **Catppuccin Mocha (Mauve)** add-on theme from addons.mozilla.org
(installed in the browser, links at https://github.com/catppuccin/firefox). Not used on the reference machine.

### Thunar / file manager setup

```bash
xdg-user-dirs-update                              # create ~/Documents, ~/Downloads, ...
xdg-mime default thunar.desktop inode/directory   # Thunar = default file manager

# Sidebar bookmarks (generated, because they contain absolute paths)
mkdir -p ~/Pictures/screenshots ~/Projects
cat > ~/.config/gtk-3.0/bookmarks <<EOF
file://$HOME/Documents Documents
file://$HOME/Downloads Downloads
file://$HOME/Pictures Pictures
file://$HOME/Pictures/screenshots Screenshots
file://$HOME/Projects Projects
EOF
```

## 4. Restoring the configs from this repo

`home/` mirrors `$HOME`. Back up your current files first, then:

```bash
cp -r home/. ~/
chmod +x ~/.config/polybar/launch.sh ~/.config/rofi/powermenu.sh
mkdir -p ~/Pictures/screenshots
fc-cache -f
```

Then recreate the GTK4 symlinks, run the Thunar setup commands (section 3) and log out / back in (SDDM reads `~/.xprofile` at login).

## 5. File map

| File | What it configures |
|---|---|
| `home/.bashrc` | PATH, aliases, history, Oh My Posh init |
| `home/.xprofile` | Qt/GTK env vars, `TERMINAL` (sourced by SDDM) |
| `home/.gtkrc-2.0` | GTK2 theme/icons/font |
| `home/.config/alacritty/alacritty.toml` | Terminal: Mocha colors, JetBrains Mono |
| `home/.config/i3/config` | WM: keybinds, Mocha borders, gaps, autostart |
| `home/.config/polybar/config.ini` | Top bar modules |
| `home/.config/polybar/launch.sh` | Polybar (re)launcher |
| `home/.config/rofi/config.rasi` | Rofi settings |
| `home/.config/rofi/catppuccin-mocha.rasi` | Rofi theme |
| `home/.config/rofi/powermenu.sh` | Lock / logout / reboot / shutdown menu |
| `home/.config/dunst/dunstrc` | Notifications |
| `home/.config/picom/picom.conf` | Compositor (xrender, vsync, no effects) |
| `home/.config/ohmyposh/catppuccin-mocha.omp.json` | Shell prompt theme |
| `home/.config/btop/btop.conf`, `themes/catppuccin_mocha.theme` | btop |
| `home/.config/fontconfig/fonts.conf` | JetBrains Mono as default mono/sans/serif |
| `home/.config/gtk-3.0/settings.ini`, `gtk-4.0/settings.ini` | GTK3/4 theme, icons, font |
| `home/.config/Kvantum/` | Kvantum config + Catppuccin theme |
| `home/.config/qt5ct/qt5ct.conf` | Qt5 style/icons/font |
| `home/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml` | Thunar preferences (icon view, folders first, thumbnails, …) |
| `home/.config/xfce4/helpers.rc` | Alacritty as terminal / Thunar as file manager for "Open Terminal Here" |
| `home/.config/Thunar/uca.xml` | Thunar right-click actions: Open Alacritty Here, Edit as Root, Copy Path |
| `home/.themes/catppuccin-mocha-mauve-standard+default/` | GTK theme |
| `home/Pictures/wallpapers/catppuccin-mocha.png` | Wallpaper (locally generated) |
