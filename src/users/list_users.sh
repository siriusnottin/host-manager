#!/usr/bin/env bash

echo ""
echo "Liste des utilisateurs :"
awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd

source "$SCRIPT_PATH/src/utils/display_menu.sh"

options=("Modifier un utilisateur" "Revenir au menu principal")
display_menu "Que voulez-vous faire ?" "${options[@]}"
case $REPLY in
1) source $SCRIPT_PATH/src/users/edit_user/edit_user_menu.sh ;;
2) clear && source $SCRIPT_PATH/host_manager.sh ;;
esac
