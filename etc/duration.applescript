tell application "iTunes"
  set pos to get player position
  set max to get duration of current track
  (pos / max) * 100
end tell
