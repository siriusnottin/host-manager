#!/usr/bin/env bash

source "$SCRIPT_PATH/src/backups/users_backup/users_backup.sh"

while true; do
  clear
  options=("Faire une sauvegarde" "Afficher l'aide" "Revenir au menu principal")
  display_menu "Gestion des sauvegardes" "${options[@]}"
  case $REPLY in
  1) source "$SCRIPT_PATH/src/backups/users_backup/users_backup.sh" ;;
  2) source "$SCRIPT_PATH/src/help/backups_help.sh" ;;
  3) source "$SCRIPT_PATH/host_manager.sh" ;;
  *) echo "Option invalide, veuillez réessayer." ;;
  esac
done
