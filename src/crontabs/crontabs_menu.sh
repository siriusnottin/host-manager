#!/usr/bin/env bash

list_current_user_crontab() {
  echo "Current user's crontab:"
  echo ""
  crontab -l
  echo ""

  options=("Edit crontab" "Back to crontab management menu")
  display_menu "What do you want to do next?" "${options[@]}"
  case $REPLY in
  1) crontab -e ;;
  2) return ;;
  esac
}

list_user_crontab() {
  read -p "Enter the username to list the crontab: " username
  echo "$username's crontab:"
  echo ""
  sudo crontab -u "$username" -l
  echo ""

  options=("Edit crontab" "Back to crontab management menu")
  display_menu "What do you want to do next?" "${options[@]}"
  case $REPLY in
  1) sudo crontab -u "$username" -e ;;
  2) return ;;
  esac
}

edit_user_crontab() {
  read -p "Enter the username to edit the crontab: " username

  echo "Editing $username's crontab..."
  sudo crontab -u "$username" -e
  if [ $? -eq 0 ]; then
    echo "Crontab for $username edited successfully."
    echo "Returning to crontab management menu..."
    sleep 1
    return
  fi
}

while true; do
  clear
  options=("Lister les crontabs de l'utilisateur courant" "Lister les crontabs d'un utilisateur spécifique" "Éditer les crontabs d'un utilisateur" "Afficher l'aide" "Revenir au menu principal")
  display_menu "Gestion des crontabs" "${options[@]}"
  case $REPLY in
  1) list_current_user_crontab ;;
  2) list_user_crontab ;;
  3) edit_user_crontab ;;
  4) source "$SCRIPT_PATH/src/help/crontabs_help.sh" ;;
  5) source "$SCRIPT_PATH/host_manager.sh" ;;
  *) echo "Option invalide, veuillez réessayer." ;;
  esac
done
