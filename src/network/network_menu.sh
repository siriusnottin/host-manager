#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

while true; do
  options=("Afficher les informations" "Configurer les paramètres réseau" "Afficher l'aide" "Revenir au menu principal")
  display_menu "Gestion du réseau" "${options[@]}"
  case $REPLY in
  1) "$SCRIPT_PATH/src/network/display_network_interfaces_infos.sh" ;;
  2) "$SCRIPT_PATH/src/network/configure_network_menu.sh" ;;
  3) source "$SCRIPT_PATH/src/help/network_help.sh" ;;
  4) source "$SCRIPT_PATH/host_manager.sh" ;;
  *) echo "Option invalide. Essayez une autre option." ;;
  esac
done
