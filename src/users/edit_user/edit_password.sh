#!/usr/bin/env bash
clear

source "$SCRIPT_PATH/src/utils/display_menu.sh"

read -p "Entrez le nom de l'utilisateur à modifier : " USERNAME

if ! id "$USERNAME" &>/dev/null; then
  echo "L'utilisateur '$USERNAME' n'existe pas."
  options=("Réessayer" "Créer un nouvel utilisateur" "Revenir au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source sous_menu_modif_utilisateur ;;
  2) source "$SCRIPT_PATH/src/users/create_user.sh" ;;
  3) source "$SCRIPT_PATH/host_manager.sh" ;;
  esac
else
  clear
  read -sp "Entrez le nouveau mot de passe : " PASSWORD
  echo ""

  echo "$USERNAME:$PASSWORD" | chpasswd
  \  && echo "Le mot de passe de l'utilisateur '$USERNAME' a été changé."
  \  || echo "Une erreur s'est produite lors du changement du mot de passe de l'utilisateur '$USERNAME'." && exit 1
fi
