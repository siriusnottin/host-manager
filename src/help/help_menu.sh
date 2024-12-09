#!/usr/bin/env bash

# Help menu

source "$SCRIPT_PATH/src/utils/display_menu.sh"

help_menu() {
  while true; do
    options=("Utilisateurs" "Logiciels" "Réseau" "Sauvegardes" "Crontabs")
    display_menu "Host Manager : Aide" "${options[@]}"
    case $REPLY in
    1) source "$SCRIPT_PATH/src/help/users_help.sh" ;;
    2) source "$SCRIPT_PATH/src/help/software_help.sh" ;;
    3) source "$SCRIPT_PATH/src/help/network_help.sh" ;;
    4) source "$SCRIPT_PATH/src/help/backups_help.sh" ;;
    5) source "$SCRIPT_PATH/src/help/crontabs_help.sh" ;;
    6) break ;;
    *) echo "Option invalide, veuillez réessayer." ;;
    esac
  done
}

clear
help_menu
