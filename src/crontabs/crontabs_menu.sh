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
  crontab -u "$username" -l
  echo ""

  options=("Edit crontab" "Back to crontab management menu")
  display_menu "What do you want to do next?" "${options[@]}"
  case $REPLY in
  1) crontab -u "$username" -e ;;
  2) return ;;
  esac
}

edit_user_crontab() {
  read -p "Enter the username to edit the crontab: " username

  echo "Editing $username's crontab..."
  crontab -u "$username" -e
  if [ $? -eq 0 ]; then
    echo "Crontab for $username edited successfully."
    echo "Returning to crontab management menu..."
    sleep 1
    return
  fi
}

while true; do
  options=("List current user's crontab" "List a specific user's crontab" "Edit a user's crontab" "Back to main menu")
  display_menu "Crontab Management" "${options[@]}"
  case $REPLY in
  1) list_current_user_crontab ;;
  2) list_user_crontab ;;
  3) edit_user_crontab ;;
  4) break ;;
  *) echo "Invalid option, please try again." ;;
  esac
done
