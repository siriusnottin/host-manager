# Host Manager

## Description

Script to manage important aspects of a Linux system. This script is interactive, as it is developped as a Command Line Interface (CLI).

It is usable as a normal user, but some commands require root privileges. In this case, the script will ask for the root password.

## Installation

```bash
git clone
cd host-manager
chmod +x host-manager.sh
ln -s $(pwd)/host-manager.sh /usr/local/bin/hostmanager
```

## Usage

```bash
hostmanager [command]
```

## Commands

- `users`: Manage system users
- `software`: Manage installed software
- `network`: Manage network settings
- `backup`: Backup personal files
- `crontab`: Manage crontab tasks
- `help`: Display help message

## Features

### Users management

- List system users
- Add a user
- Edit a user

### Software management

- List installed software
- Install a software from it's repository or a source file
- Remove a software

### Network management

- Display network information
  - Name
  - IP address
  - MAC address
  - Gateway
  - DNS
  - DHCP
  - Connection status
  - Connection type
  - Connection speed
- Configure network settings
  - IP address
  - Subnet mask
  - Gateway
  - DNS
  - DHCP

### Backup of personal files

Full backup of all user's personal folders on an external storage device. `/mnt/export` is used here.

### Crontab management

- List current user's crontab
- List a specific user's crontab
- Edit a user's crontab (add, remove, edit tasks)
