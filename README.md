# Catppuccin Mocha i3 Rice

A clean, functional **Arch Linux + i3** rice in the **Catppuccin Mocha** palette (mauve accent),
built to run smoothly inside **VirtualBox**: no blur, shadows, transparency or animations.
Everything comes from the official Arch repos. **No AUR.**

![palette](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7?style=flat-square&labelColor=1e1e2e)
![wm](https://img.shields.io/badge/wm-i3-89b4fa?style=flat-square&labelColor=1e1e2e)
![font](https://img.shields.io/badge/font-JetBrains%20Mono%20Nerd-a6e3a1?style=flat-square&labelColor=1e1e2e)

## Stack

| Role | Tool | Notes |
|---|---|---|
| Window manager | **i3** | 2px mauve borders, 8px gaps, no title bars |
| Terminal | **Alacritty** | Opens with Super+Enter |
| Shell prompt | **Oh My Posh** (bash) | Custom Catppuccin Mocha theme with powerline segments. No zsh |
| Status bar | **Polybar** | At the top: workspaces, window title, clock, CPU, RAM, disk, network, volume, tray, power button |
| Launcher / menus | **Rofi** | App launcher, run prompt, window switcher, power menu |
| Notifications | **Dunst** | Mocha colors, colored frame by urgency |
| Compositor | **picom** | `xrender` backend with vsync only, to stop tearing. No effects |
| File manager | **Thunar** | With archive, volume and thumbnail plugins, and Alacritty right-click actions |
| Browser | **Firefox** | No config of its own: takes JetBrains Mono from fontconfig, and its built-in "System theme — auto" draws the UI with the Catppuccin GTK theme |
| Wallpaper | **feh** | Mocha gradient generated locally |
| Lock screen | **i3lock** | Solid Mocha base color, started by `xss-lock` |
| Screenshots | **maim + xclip** | Saved to `~/Pictures/screenshots` and copied to the clipboard |
| System monitor | **btop** | Catppuccin Mocha theme |
| System info | **fastfetch** | |

## Theme, icons and fonts

| What | Used | Source |
|---|---|---|
| Color palette | **Catppuccin Mocha** (accent: mauve `#cba6f7`) | [catppuccin.com](https://catppuccin.com) |
| GTK 2/3/4 theme | `catppuccin-mocha-mauve-standard+default` | [catppuccin/gtk](https://github.com/catppuccin/gtk) release v1.0.3, included in `home/.themes/` |
| Qt theme | Kvantum `catppuccin-mocha-mauve`, applied through `qt5ct` | [catppuccin/Kvantum](https://github.com/catppuccin/Kvantum), included in `home/.config/Kvantum/` |
| Icon pack | **Papirus-Dark** | `papirus-icon-theme` (pacman) |
| Cursor | Adwaita | default |
| Main font | **JetBrainsMono Nerd Font**: the default for monospace, sans-serif and serif through fontconfig | `ttf-jetbrains-mono-nerd` (pacman) |
| Fallback fonts | Noto Sans, Noto Serif, Noto Color Emoji | `noto-fonts`, `noto-fonts-emoji` (pacman) |
| Terminal, bar, rofi, dunst, prompt | Catppuccin Mocha colors written by hand into each config | this repo |
| Firefox | Built-in "System theme — auto", which renders with the Catppuccin GTK theme, plus the system font from fontconfig. No add-on needed (an official Catppuccin add-on exists as an alternative) | [catppuccin/firefox](https://github.com/catppuccin/firefox) |

## Packages

**From pacman (official repos):**

- **Desktop:** `i3-wm` `alacritty` `polybar` `rofi` `dunst` `libnotify` `picom` `feh` `i3lock` `xss-lock`
- **Fonts and theming:** `ttf-jetbrains-mono-nerd` `noto-fonts` `noto-fonts-emoji` `papirus-icon-theme` `lxappearance` `kvantum` `qt5ct`
- **File manager:** `thunar` `gvfs` `thunar-archive-plugin` `thunar-volman` `tumbler` `ffmpegthumbnailer` `xarchiver` `xdg-user-dirs`
- **Browser:** `firefox`
- **Utilities:** `maim` `xclip` `xdotool` `playerctl` `pavucontrol` `network-manager-applet` `libpulse` `btop` `fastfetch` `git` `curl` `unzip`
- **VirtualBox only:** `virtualbox-guest-utils`, plus the `vboxservice` service

**Not from pacman:**
- **Oh My Posh**, installed with its official script into `~/.local/bin`
- The **Catppuccin GTK and Kvantum themes**, downloaded from Catppuccin's GitHub. They're already included in this repo.

The exact commands are in [REQUIREMENTS.md](REQUIREMENTS.md).

## Keybindings

| Keys | Action |
|---|---|
| `Super + Enter` | Terminal (Alacritty) |
| `Super + Shift + F` | File manager (Thunar) |
| `Super + D` / `Super + Shift + D` | Apps / run a command (Rofi) |
| `Super + Tab` | Window switcher |
| `Super + Shift + E` | Power menu (lock, logout, reboot, shutdown) |
| `Super + Shift + X` | Lock screen |
| `Print` / `Shift + Print` / `Super + Print` | Screenshot of the full screen / a selected area / the active window |
| `Super + G` / `Super + Shift + G` | Toggle inner / outer gaps |
| `Super + N` / ``Super + ` `` | Dismiss notifications / bring back the last one |
| `Super + Shift + Q` | Close window |
| `Super + J K L ;` or the arrow keys | Move focus (add Shift to move the window) |
| `Super + F` | Fullscreen |
| `Super + R` | Resize mode |
| `Super + Shift + C` / `R` | Reload / restart i3 |

Media keys control volume through `pactl` and playback through `playerctl`.
In Polybar, click the Arch logo to open the app launcher and the power icon to open the power menu.
Right-click the volume to open `pavucontrol`.

## Repo layout

```
.
├── README.md          ← this file
├── REQUIREMENTS.md    ← all install commands + file map
├── prompt.txt         ← Claude Code prompt that applies this rice on another machine
└── home/              ← mirrors $HOME, copy into ~
    ├── .bashrc  .xprofile  .gtkrc-2.0
    ├── .config/  alacritty  i3  polybar  rofi  dunst  picom  ohmyposh  btop
    │             fontconfig  gtk-3.0  gtk-4.0  Kvantum  qt5ct  xfce4  Thunar
    ├── .themes/catppuccin-mocha-mauve-standard+default/
    └── Pictures/wallpapers/catppuccin-mocha.png
```

## Install

**With Claude Code (recommended):** open Claude Code in this folder and give it the contents of `prompt.txt`.
It detects whether the machine is VirtualBox or real hardware and prints the matching pacman command and installer commands.
It waits for you to run them, then backs up your configs, applies the rice and adjusts it to the machine (Wi-Fi, battery, login manager).

**By hand:** follow [REQUIREMENTS.md](REQUIREMENTS.md): packages, then Oh My Posh, then `cp -r home/. ~/`, then the post-install commands. Log out and back in at the end.
