#!/usr/bin/env bash

# Do a full backup of all users home directories

function get_human_users {
  awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd
}

read -p "Enter the backup directory path: (default to /mnt/export): " BACKUP_DIR

if [ -z "$BACKUP_DIR" ]; then
  BACKUP_DIR="/mnt/export"
fi

# check if the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "The backup directory $BACKUP_DIR does not exist."
  options=("Create the directory" "Try again" "Edit the backup directory path" "Revenir au menu principal")
  display_menu "What do you want to do?" "${options[@]}"
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
  echo "Backing up $user home directory in $BACKUP_DIR/$user"
  sudo tar -czf "$BACKUP_DIR/$user.tar.gz" "/home/$user" &
  echo "Backup of $user home directory started."
  wait
  echo "Renaming the backup file..."
  sudo mv "$BACKUP_DIR/$user.tar.gz" "$BACKUP_DIR/$user.tar.gz.$(date +%Y%m%d)" && echo "Backup of $user home directory done."
  sleep 1
  source "$SCRIPT_PATH/host_manager.sh"
done
