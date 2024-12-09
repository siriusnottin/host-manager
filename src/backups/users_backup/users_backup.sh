#!/usr/bin/env bash

# Do a full backup of all users home directories

function get_human_users {
  awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd
}

read -p "Entrez le chemin du répertoire de sauvegarde (par défaut /mnt/export) : " BACKUP_DIR

if [ -z "$BACKUP_DIR" ]; then
  BACKUP_DIR="/mnt/export"
fi

# check if the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Le répertoire de sauvegarde $BACKUP_DIR n'existe pas."
  options=("Créer le répertoire" "Réessayer" "Modifier le chemin du répertoire de sauvegarde" "Retour au menu principal")
  display_menu "Que voulez-vous faire ?" "${options[@]}"
  case $REPLY in
  1) sudo mkdir -p "$BACKUP_DIR" ;;
  2) source "$SCRIPT_PATH/src/backups/users_backup/users_backup.sh" ;;
  3) source "$SCRIPT_PATH/src/backups/users_backup/users_backup.sh" ;;
  4) source "$SCRIPT_PATH/host_manager.sh" ;;
  esac
fi

# Backup all users home directories
for user in $(get_human_users); do
  # start the backup in the background
  echo "Sauvegarde du répertoire personnel de $user dans $BACKUP_DIR/$user"
  sudo tar -czf "$BACKUP_DIR/$user.tar.gz" "/home/$user" &
  echo "Sauvegarde du répertoire personnel de $user démarrée."
  wait
  echo "Renommage du fichier de sauvegarde..."
  sudo mv "$BACKUP_DIR/$user.tar.gz" "$BACKUP_DIR/$user.tar.gz.$(date +%Y%m%d)" && echo "Sauvegarde du répertoire personnel de $user terminée."
  sleep 1
  source "$SCRIPT_PATH/host_manager.sh"
done
