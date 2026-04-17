#!/usr/bin/env bash

# File: tools/weather.sh
# Description: Fetches and caches current weather information for a specified city using Open-Meteo API.
# Dependencies: curl, jq, md5sum, stat

set -euo pipefail

# Check for required dependencies
for cmd in curl jq md5sum stat; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required dependency '$cmd' is not installed." >&2
        exit 1
    fi
done

CACHE_TTL=300  # seconds between API calls

CITY="${*:?Usage: weather.sh <city name>}"
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
GEO=$(curl -sf "https://geocoding-api.open-meteo.com/v1/search?name=${ENCODED_CITY}&count=1")
LAT=$(printf '%s' "$GEO" | jq -r '.results[0].latitude // empty')
LON=$(printf '%s' "$GEO" | jq -r '.results[0].longitude // empty')

if [[ -z "$LAT" || -z "$LON" ]]; then
  printf '❓ %s?' "$CITY"
  exit 1
fi

# Fetch current weather + daily min/max
WEATHER=$(curl -sf "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current_weather=true&daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=1")

CODE=$(printf '%s' "$WEATHER" | jq -r '.current_weather.weathercode')
TEMP=$(printf '%s' "$WEATHER" | jq -r '.current_weather.temperature')
TMIN=$(printf '%s' "$WEATHER" | jq -r '.daily.temperature_2m_min[0]')
TMAX=$(printf '%s' "$WEATHER" | jq -r '.daily.temperature_2m_max[0]')

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
