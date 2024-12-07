#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Software management menu

while true; do
  options=("List installed software" "Install a software" "Remove a software" "Back to main menu")
  display_menu "Software Management" "${options[@]}"
  case $REPLY in
  1) echo "List installed software selected" ;; # Add logic to list software
  2) echo "Install a software selected" ;;      # Add logic to install software
  3) echo "Remove a software selected" ;;       # Add logic to remove software
  4) break ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
