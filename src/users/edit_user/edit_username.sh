#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

echo "Attention : le répertoire personnel de l'utilisateur sera déplacé."
read -p "Nom d'utilisateur à modifier : " USERNAME

if ! id "$USERNAME" &>/dev/null; then
  echo "L'utilisateur '$USERNAME' n'existe pas."
  echo "Retour au menu utilisateur..."
  sleep 1
  source "$SCRIPT_PATH/src/users/users_menu.sh"
else
  read -p "Nouveau nom d'utilisateur : " USERNAME_NEW
  usermod -lm "$USERNAME_NEW" "$USERNAME"
  \  && echo "Le nom de l'utilisateur a été changé en '$USERNAME_NEW'."
  \  || echo "Une erreur s'est produite lors du changement du nom de l'utilisateur." && exit 1
fi
