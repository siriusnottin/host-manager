#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

clear
while true; do
  options=("Lister les utilisateurs du système" "Ajouter un nouvel utilisateur" "Modifier un utilisateur" "Afficher l'aide" "Revenir au menu principal")
  display_menu "Gestion des utilisateurs" "${options[@]}"
  case $REPLY in
  1) source "$SCRIPT_PATH/src/users/list_users.sh" ;;
  2) source "$SCRIPT_PATH/src/users/create_user.sh" ;;
  3) source "$SCRIPT_PATH/src/users/edit_user/edit_user_menu.sh" ;;
  4) source "$SCRIPT_PATH/src/help/users_help.sh" ;;
  5) source "$SCRIPT_PATH/host_manager.sh" ;;
  *) echo "Option invalide, veuillez réessayer." ;;
  esac
done
