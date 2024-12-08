#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

while true; do
  options=("Afficher les informations " "Configure network settings" "Back to main menu")
  display_menu "Network Management" "${options[@]}"
  case $REPLY in
  1) "$SCRIPT_PATH/src/network/display_network_interfaces_infos.sh" ;;
  2)
    "$SCRIPT_PATH/src/network/configure_network_menu.sh"
    ;;
  3) exit ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
