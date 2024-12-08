#!/usr/bin/env bash

# Get the current script absolute path
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPT_PATH

source "$SCRIPT_PATH/src/utils/display_menu.sh"

main_menu() {
  while true; do
    options=("Gestion des utilisateurs" "Gestion des logiciels" "Gestion du réseau" "Sauvegarde des dossier utilisateurs" "Gestion des crontabs" "Aide")
    display_menu "Host Manager : Menu Principal" "${options[@]}"
    case $REPLY in
    1) source "$SCRIPT_PATH/src/users/users_menu.sh" ;;
    2) source "$SCRIPT_PATH/src/software/software_menu.sh" ;;
    3) source "$SCRIPT_PATH/src/network/network_menu.sh" ;;
    4) source "$SCRIPT_PATH/src/backups/users_backup/users_backup_menu.sh" ;;
    5) source "$SCRIPT_PATH/src/crontabs/crontabs_menu.sh" ;;
    6) echo "Aide sélectionnée" ;; # Add help logic here
    *) echo "Option invalide, veuillez réessayer." ;;
    esac
  done
}

main_menu
