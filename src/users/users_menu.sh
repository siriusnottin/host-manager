#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Users management menu

while true; do
  options=("List system users" "Add a user" "Edit a user" "Back to main menu")
  display_menu "Users Management" "${options[@]}"
  case $REPLY in
  1) echo "List system users selected" ;; # Add logic to list users
  2) echo "Add a user selected" ;;        # Add logic to add a user
  3) echo "Edit a user selected" ;;       # Add logic to edit a user
  4) break ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
