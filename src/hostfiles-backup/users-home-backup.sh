#!/usr/bin/env bash

# Do a full backup of all users home directories
# in a external hard drive (simulated here by a directory)

sudo mkdir -p /mnt/export # Simulate external backup with placeholder folder in /mnt

# List all users
function get_human_users {
  awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd
}

human_users=$(get_human_users)

# Backup all users home directories
for user in $human_users; do
  echo "Backing up $user home directory..."
  sudo cp -r /home/$user /mnt/export/$user
done
