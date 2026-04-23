#!/usr/bin/env bash

# File: tmux/tmux-weather.sh
# Description: Fetches and caches current weather information for a specified city using Open-Meteo API.
# Dependencies: curl, jq, md5sum, stat

CACHE_TTL=300  # seconds between API calls

CITY="$*"
if [[ -z "$CITY" ]]; then
    echo "❓ no city"
    exit 0
fi

# Check for required dependencies
for cmd in curl jq md5sum stat; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❓ missing $cmd"
        exit 0
    fi
done

CACHE_FILE="/tmp/weather_cache_$(printf '%s' "$CITY" | md5sum | cut -d' ' -f1)"

# Serve from cache if fresh enough
if [[ -f "$CACHE_FILE" ]]; then
  AGE=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE") ))
  if (( AGE < CACHE_TTL )); then
    cat "$CACHE_FILE"
    exit 0
  fi
fi

ENCODED_CITY=$(printf '%s' "$CITY" | jq -sRr @uri)

# Geocode city name
GEO=$(curl -sf --max-time 5 "https://geocoding-api.open-meteo.com/v1/search?name=${ENCODED_CITY}&count=1" 2>/dev/null) || true
LAT=$(printf '%s' "$GEO" | jq -r '.results[0].latitude // empty' 2>/dev/null) || true
LON=$(printf '%s' "$GEO" | jq -r '.results[0].longitude // empty' 2>/dev/null) || true

if [[ -z "$LAT" || -z "$LON" ]]; then
  echo "❓ $CITY?"
  exit 0
fi

# Fetch current weather + daily min/max
WEATHER=$(curl -sf --max-time 5 "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current_weather=true&daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=1" 2>/dev/null) || true

CODE=$(printf '%s' "$WEATHER" | jq -r '.current_weather.weathercode // empty' 2>/dev/null) || true
TEMP=$(printf '%s' "$WEATHER" | jq -r '.current_weather.temperature // empty' 2>/dev/null) || true
TMIN=$(printf '%s' "$WEATHER" | jq -r '.daily.temperature_2m_min[0] // empty' 2>/dev/null) || true
TMAX=$(printf '%s' "$WEATHER" | jq -r '.daily.temperature_2m_max[0] // empty' 2>/dev/null) || true

if [[ -z "$TEMP" ]]; then
  echo "❓ offline"
  exit 0
fi

# Round temperatures to integers
TEMP=$(printf '%.0f' "$TEMP")
TMIN=$(printf '%.0f' "$TMIN")
TMAX=$(printf '%.0f' "$TMAX")

# WMO weather code to emoji
wmo_emoji() {
  case "$1" in
    0)           echo "☀️";;
    1)           echo "🌤️";;
    2)           echo "⛅";;
    3)           echo "☁️";;
    45|48)       echo "🌫️";;
    51|53|55)    echo "🌦️";;
    61|63|65)    echo "🌧️";;
    66|67)       echo "🌧️❄️";;
    71|73|75|77) echo "🌨️";;
    80|81|82)    echo "🌧️";;
    85|86)       echo "🌨️";;
    95)          echo "⛈️";;
    96|99)       echo "⛈️🧊";;
    *)           echo "❓";;
  esac
}

EMOJI=$(wmo_emoji "$CODE")

OUTPUT=$(printf '%s %s°C (🔻%s°/🔺%s°)' "$EMOJI" "$TEMP" "$TMIN" "$TMAX")
printf '%s' "$OUTPUT" | tee "$CACHE_FILE"
