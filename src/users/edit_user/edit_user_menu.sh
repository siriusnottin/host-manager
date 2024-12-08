#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

edit_user_menu() {
  options=("Modifier le nom d'utilisateur" "Modifier le mot de passe" "Modifier le groupe principal" "Retour au menu utilisateur" "Retour au menu principal")
  display_menu "Modifier l'utilisateur : $USERNAME" "${options[@]}"
  case $REPLY in
  1) source $SCRIPT_PATH/src/users/edit_user/edit_username.sh ;;
  2) source $SCRIPT_PATH/src/users/edit_user/edit_password.sh ;;
  3) source $SCRIPT_PATH/src/users/edit_user/edit_user_group.sh ;;
  4) source $SCRIPT_PATH/src/users/users_menu.sh ;;
  5) source $SCRIPT_PATH/host_manager.sh ;;
  esac
}
