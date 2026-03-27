swww img "$1" --transition-type $(jq -r .wallpaper.swwwTransition ~/.config/quickshell/vars/settings.json) --transition-duration 1
matugen image "$1" 
qs ipc call colors reload
