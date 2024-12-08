#!/usr/bin/env bash

read -p "Entrez le nom d'utilisateur : " USERNAME
if id "$USERNAME" &>/dev/null; then
  echo "L'utilisateur $USERNAME existe déjà."
  options=("Modifier l'utilisateur" "Retour au menu principal")
  display_menu "L'utilisateur existe déjà. Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source $SCRIPT_PATH/src/users/edit_user/edit_user_menu.sh ;;
  3) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

# Demander le mot de passe à l'utilisateur
read -sp "Mot de passe pour $USERNAME : " PASSWORD
echo ""

# Demander le groupe principal
read -p "Groupe principal pour $USERNAME (laissez vide pour le groupe par défaut) : " USER_MAIN_GROUP

if ! getent group "$USER_MAIN_GROUP" &>/dev/null; then
  echo "Le groupe $USER_MAIN_GROUP n'existe pas."
  options=("Créer le groupe" "Annuler")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) groupadd "$USER_MAIN_GROUP" ;;
  2) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

useradd -m -g "$USER_MAIN_GROUP" "$USERNAME"

# Ajouter le mot de passe à l'utilisateur
echo "$USERNAME:$PASSWORD" | chpasswd

echo "L'utilisateur $USERNAME a été créé avec succès."
echo ""

echo "Informations de l'utilisateur :"
echo "Nom d'utilisateur : $USERNAME"
echo "Groupe principal : $USER_MAIN_GROUP"
echo ""

read -n 1 -s -r -p "Appuyez sur n'importe quelle touche pour revenir au menu principal..."
source $SCRIPT_PATH/host_manager.sh
