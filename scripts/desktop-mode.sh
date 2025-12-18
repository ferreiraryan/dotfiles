#!/usr/bin/env bash
set -e

echo "🖥️  Ativando DESKTOP MODE (visual + comfy)"

# =========================
# 1. MACHINE selector
# =========================
MACHINE_CONF="$HOME/.config/hypr/machine.conf"

echo "➡️  Setando MACHINE=desktop"
mkdir -p "$(dirname "$MACHINE_CONF")"
printf '$MACHINE = desktop\n' > "$MACHINE_CONF"

# =========================
# 2. Waybar profile (desktop)
# =========================
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_MACHINE="$WAYBAR_DIR/machines/desktop"

echo "➡️  Configurando Waybar desktop"
mkdir -p "$WAYBAR_MACHINE"

cat > "$WAYBAR_MACHINE/config" <<'EOF'
{
  "layer": "top",
  "height": 30,

  "modules-left": ["workspaces", "window"],
  "modules-center": ["clock"],
  "modules-right": ["cpu", "memory", "network", "pulseaudio", "tray"],

  "clock": {
    "interval": 30,
    "format": "{:%a %d/%m  %H:%M}"
  },

  "cpu": { "interval": 3, "format": " {usage}%" },
  "memory": { "interval": 3, "format": "󰍛 {used:0.1f}G" },

  "network": {
    "interval": 3,
    "tooltip": true,
    "format-wifi": " {signalStrength}%",
    "format-ethernet": "󰈀 {ifname}"
  },

  "pulseaudio": {
    "scroll-step": 2,
    "format": " {volume}%",
    "format-muted": "󰖁 muted"
  }
}
EOF

cat > "$WAYBAR_MACHINE/style.css" <<'EOF'
* {
  font-family: "JetBrainsMono Nerd Font", monospace;
  font-size: 12px;
  min-height: 0;
}

window#waybar {
  background: rgba(0,0,0,0.45);
  color: #ffffff;
}

#workspaces button {
  padding: 0 8px;
  margin: 4px 3px;
  border-radius: 8px;
  opacity: 0.6;
}

#workspaces button.active {
  opacity: 1.0;
}

#clock, #cpu, #memory, #network, #pulseaudio, #tray, #window {
  padding: 0 10px;
}
EOF

ln -sf "$WAYBAR_MACHINE/config" "$WAYBAR_DIR/config"
ln -sf "$WAYBAR_MACHINE/style.css" "$WAYBAR_DIR/style.css"

# =========================
# 3. Hyprland prefs (desktop)
# =========================
DESKTOP_PREFS="$HOME/.config/hypr/userprefs/desktop.conf"
mkdir -p "$(dirname "$DESKTOP_PREFS")"

cat > "$DESKTOP_PREFS" <<'EOF'
general {
  gaps_in = 6
  gaps_out = 12
  border_size = 2
}

animations {
  enabled = true
}

decoration {
  rounding = 10
  blur {
    enabled = true
    size = 6
    passes = 2
    new_optimizations = true
  }
  shadow {
    enabled = true
    range = 20
    render_power = 3
  }
}

misc {
  disable_hyprland_logo = true
  mouse_move_enables_dpms = true
  key_press_enables_dpms = true
}
EOF

# =========================
# 4. Reload
# =========================
echo "🔄 Recarregando Hyprland & Waybar"
hyprctl reload || true
pkill waybar || true
sleep 0.3
waybar &

echo "✅ DESKTOP MODE ATIVO"

