#!/usr/bin/env sh
xset -dpms
xset s off
xset s noblank

unclutter -idle 0.08 -root -noevents &
chromium-browser https://github.com/felix068/WP_Kiosk_Raspi \
  --window-size=800,480 \
  --window-position=0,0 \
  --start-fullscreen \
  --kiosk \
  --noerrdialogs \
  --disable-translate \
  --no-first-run \
  --fast \
  --fast-start \
  --disable-infobars \
  --disable-features=TranslateUI \
  --disk-cache-dir=/dev/null \
  --overscroll-history-navigation=0 \
  --disable-pinch
