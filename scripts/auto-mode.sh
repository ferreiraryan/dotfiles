#!/usr/bin/env bash
set -e

BASE="$HOME/dotfiles/scripts"
NB="$BASE/notebook-mode.sh"
DT="$BASE/desktop-mode.sh"

detect_battery_mode() {
  # Se existir upower, é o melhor
  if command -v upower >/dev/null; then
    local dev
    dev="$(upower -e | grep -m1 -E 'battery|BAT')"
    if [[ -n "$dev" ]]; then
      upower -i "$dev" | grep -qi "state:\s*discharging" && return 0
      return 1
    fi
  fi

  # fallback: sysfs
  for p in /sys/class/power_supply/BAT*; do
    [[ -e "$p/status" ]] || continue
    grep -qi "Discharging" "$p/status" && return 0
    return 1
  done

  # se não achou bateria, assume desktop
  return 1
}

if detect_battery_mode; then
  echo "🔋 Detectado: rodando na BATERIA → NOTEBOOK MODE"
  exec "$NB"
else
  echo "🔌 Detectado: CARREGANDO/SEM BATERIA → DESKTOP MODE"
  exec "$DT"
fi

