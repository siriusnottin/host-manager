#!/usr/bin/env bash
clear
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

clear
# Demander le mot de passe à l'utilisateur
read -sp "Mot de passe pour $USERNAME : " PASSWORD
echo ""

# Demander le groupe principal
read -p "Groupe principal pour $USERNAME (laissez vide pour le groupe par défaut) : " USER_MAIN_GROUP

if [ -z "$USER_MAIN_GROUP" ]; then
  USER_MAIN_GROUP="$USERNAME"
fi

if ! getent group "$USER_MAIN_GROUP" &>/dev/null; then
  echo "Le groupe $USER_MAIN_GROUP n'existe pas."
  options=("Créer le groupe" "Annuler")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) sudo groupadd "$USER_MAIN_GROUP" ;;
  2) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

sudo useradd -m -g "$USER_MAIN_GROUP" "$USERNAME"

if [ $? -ne 0 ]; then
  echo "Une erreur s'est produite lors de la création de l'utilisateur $USERNAME."
  options=("Réessayer" "Retour au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source $SCRIPT_PATH/src/users/create_user.sh ;;
  2) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

# Add the password to the user
sudo echo "$USERNAME:$PASSWORD" | chpasswdr

if [ $? -ne 0 ]; then
  echo "Une erreur s'est produite lors de la création du mot de passe pour l'utilisateur $USERNAME."
  options=("Réessayer" "Retour au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source $SCRIPT_PATH/src/users/create_user.sh ;;
  2) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

if ! id "$USERNAME" &>/dev/null; then
  echo "Une erreur s'est produite lors de la création de l'utilisateur $USERNAME."
  options=("Réessayer" "Retour au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) source $SCRIPT_PATH/src/users/create_user.sh ;;
  2) source $SCRIPT_PATH/host_manager.sh ;;
  esac
fi

clear
echo "L'utilisateur $USERNAME a été créé avec succès."
echo ""

echo "Informations de l'utilisateur :"
echo "Nom d'utilisateur : $USERNAME"
echo "Groupe principal : $USER_MAIN_GROUP"
echo ""

options=("Créer un autre utilisateur" "Retour au menu principal")
display_menu "Que voulez-vous faire ?" "${options[@]}"
case $REPLY in
1) source $SCRIPT_PATH/src/users/create_user.sh ;;
2) source $SCRIPT_PATH/host_manager.sh ;;
esac
