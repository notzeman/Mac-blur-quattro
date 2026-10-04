#!/bin/sh
# Media is optional; leave this label empty when playerctl is unavailable.
command -v playerctl >/dev/null 2>&1 || exit 0
[ "$(playerctl status 2>/dev/null)" = "Playing" ] || exit 0
playerctl metadata --format '{{ title }} — {{ artist }}' 2>/dev/null |
    sed 's/\&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
