#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

display_menu() {
  local title=$1
  shift
  local options=("$@")

  while true; do
    echo "$title"
    PS3="Please select an option: "
    select opt in "${options[@]}" "Quit"; do
      if ((REPLY == 1 + ${#options[@]})); then
        echo "Exiting..."
        exit 0
      elif ((REPLY > 0 && REPLY <= ${#options[@]})); then
        echo "You selected option $REPLY: $opt"
        break
      else
        echo "Invalid option. Try another one."
      fi
    done
    break
  done
}

main_menu() {
  while true; do
    options=("Users management" "Software management" "Network management" "Backup personal files" "Crontab management" "Help" "Exit")
    display_menu "Host Manager" "${options[@]}"
    case $REPLY in
    1) "$SCRIPT_DIR/src/users/users-menu.sh" ;;
    2) "$SCRIPT_DIR/src/software/software-menu.sh" ;;
    3) "$SCRIPT_DIR/src/networks/network-menu.sh" ;;
    4) "$SCRIPT_DIR/src/backup/backup-menu.sh" ;;
    5) "$SCRIPT_DIR/src/crontab/crontab-menu.sh" ;;
    6) echo "Help selected" ;; # Add help logic here
    7)
      echo "Exiting..."
      exit 0
      ;;
    esac
  done
}

main_menu
