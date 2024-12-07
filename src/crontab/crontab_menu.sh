#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Crontab management menu

while true; do
  options=("List current user's crontab" "List a specific user's crontab" "Edit a user's crontab" "Back to main menu")
  display_menu "Crontab Management" "${options[@]}"
  case $REPLY in
  1) echo "List current user's crontab selected" ;;    # Add logic to list current user's crontab
  2) echo "List a specific user's crontab selected" ;; # Add logic to list specific user's crontab
  3) echo "Edit a user's crontab selected" ;;          # Add logic to edit user's crontab
  4) break ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
