#!/usr/bin/env bash
set -e

echo "🔋 Ativando NOTEBOOK MODE (low power + smooth)"

# =========================
# 1. MACHINE selector
# =========================
MACHINE_CONF="$HOME/.config/hypr/machine.conf"

echo "➡️  Setando MACHINE=notebook"
mkdir -p "$(dirname "$MACHINE_CONF")"
printf '$MACHINE = notebook\n' > "$MACHINE_CONF"

# =========================
# 2. Waybar profile (light)
# =========================
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_MACHINE="$WAYBAR_DIR/machines/notebook"

echo "➡️  Configurando Waybar leve"
mkdir -p "$WAYBAR_MACHINE"

cat > "$WAYBAR_MACHINE/config" <<'EOF'
{
  "layer": "top",
  "height": 24,
  "modules-left": ["workspaces"],
  "modules-center": ["clock"],
  "modules-right": ["network", "pulseaudio", "battery", "tray"],

  "clock": {
    "interval": 60,
    "format": "{:%H:%M}"
  },

  "battery": {
    "interval": 30,
    "states": {
      "warning": 30,
      "critical": 15
    }
  },

  "network": {
    "interval": 10,
    "tooltip": false,
    "format-wifi": "",
    "format-ethernet": "󰈀"
  }
}
EOF

cat > "$WAYBAR_MACHINE/style.css" <<'EOF'
* {
  font-family: "JetBrainsMono Nerd Font", monospace;
  font-size: 11px;
  min-height: 0;
}

window#waybar {
  background: rgba(0,0,0,0.3);
  color: #ffffff;
}

#workspaces button {
  padding: 0 6px;
  opacity: 0.6;
}

#workspaces button.active {
  opacity: 1.0;
}
EOF

ln -sf "$WAYBAR_MACHINE/config" "$WAYBAR_DIR/config"
ln -sf "$WAYBAR_MACHINE/style.css" "$WAYBAR_DIR/style.css"

# =========================
# 3. Hyprland tweaks
# =========================
NOTEBOOK_PREFS="$HOME/.config/hypr/userprefs/notebook.conf"
mkdir -p "$(dirname "$NOTEBOOK_PREFS")"

cat > "$NOTEBOOK_PREFS" <<'EOF'
general {
  gaps_in = 3
  gaps_out = 6
  border_size = 1
}

animations {
  enabled = false
}

decoration {
  rounding = 6
  blur {
    enabled = false
  }
  shadow {
    enabled = false
  }
}

misc {
  disable_autoreload = true
  disable_hyprland_logo = true
  mouse_move_enables_dpms = false
  key_press_enables_dpms = true
}

input {
  touchpad {
    tap-to-click = true
    natural_scroll = true
    drag_lock = true
  }
}
EOF

# =========================
# 4. Power tools (if exist)
# =========================
if command -v tlp >/dev/null; then
  echo "➡️  TLP detectado"
  sudo tlp start >/dev/null 2>&1 || true
fi

if command -v powertop >/dev/null; then
  echo "➡️  Powertop auto-tune"
  sudo powertop --auto-tune >/dev/null 2>&1 || true
fi

# =========================
# 5. Reload
# =========================
echo "🔄 Recarregando Hyprland & Waybar"
hyprctl reload || true
pkill waybar || true
sleep 0.3
waybar &

echo "✅ NOTEBOOK MODE ATIVO"

