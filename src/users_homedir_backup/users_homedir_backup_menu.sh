#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Backup management menu

while true; do
  options=("Full backup of personal folders" "Back to main menu")
  display_menu "Backup Management" "${options[@]}"
  case $REPLY in
  1) echo "Full backup of personal folders selected" ;; # Add logic for backup
  2) break ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
