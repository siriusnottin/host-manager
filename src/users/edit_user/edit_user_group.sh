#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

echo "modifie le groupe principale d'un utilisateur"
read -p "Entrez le nom de l'utilisateur à modifier : " USERNAME

# ont vérifie si l'utilisateur existe et si il existe pas ont renvoie au menu utilisateur
if ! id "$USERNAME" &>/dev/null; then
  echo "L'utilisateur '$USERNAME' n'existe pas."
  options=("Créer l'utilisateur" "Modifier un autre utilisateur" "Revenir au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source "$SCRIPT_PATH/src/users/create_user.sh" ;;
  2) source "$SCRIPT_PATH/src/users/edit_user/edit_user_menu.sh" ;;
  3) source "$SCRIPT_PATH/host_manager.sh" ;;
  esac
else
  read -p "Entrez le nouveau groupe principal : " NEW_GROUP
  if ! getent group "$NEW_GROUP" &>/dev/null; then
    echo "Le groupe '$NEW_GROUP' n'existe pas."
    options=("Créer le groupe" "Revenir au menu principal")
    display_menu "Que voulez-vous faire ?" "${options[@]}"
    case $REPLY in
    1) groupadd "$NEW_GROUP" ;;
    2) source "$SCRIPT_PATH/host_manager.sh" ;;
    esac
  fi
fi
