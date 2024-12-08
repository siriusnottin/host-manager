#!/usr/bin/env bash

echo "Entrez le nom du logiciel à installer :"
read logiciel

echo "Entrez l'URL source du logiciel à installer (laissez vide pour une installation depuis un dépôt) :"
read source_url

if [ -f /etc/os-release ]; then
    # Identifier la distribution sur la quelle ont est
    ./etc/os-release
    if [ -z "$source_url" ]; then
        # Installation depuis un dépôt
        case $ID in
        ubuntu | debian)
            echo "Installation de $logiciel depuis le dépôt sur Debian/Ubuntu..."
            sudo apt update && sudo apt install -y "$logiciel"
            ;;
        rhel | centos | fedora)
            echo "Installation de $logiciel depuis le dépôt sur RHEL/CentOS/Fedora..."
            sudo dnf install -y "$logiciel" || sudo yum install -y "$logiciel"
            ;;
        arch | manjaro)
            echo "Installation de $logiciel depuis le dépôt sur Arch/Manjaro..."
            sudo pacman -S --noconfirm "$logiciel"
            ;;
        *)
            echo "Distribution non reconnue ou non prise en charge pour une installation depuis un dépôt."
            return 1
            ;;
        esac
    else
        # Installation à partir d'un fichier source
        echo "Téléchargement et installation de $logiciel depuis la source : $source_url"
        fichier=$(basename "$source_url")
        dossier=$(basename "$fichier" .tar.gz) #TODO: ??

        # Télécharger la source
        wget "$source_url" -O "$fichier" || {
            echo "Échec du téléchargement."
            return 1
        }

        # Extraire le fichier
        tar -xzf "$fichier" || {
            echo "Échec de l'extraction."
            return 1
        }

        # Compilation et installation
        cd "$dossier" || {
            echo "Impossible d'accéder au dossier des sources."
            return 1
        }
        ./configure && make && sudo make install || {
            echo "Échec de la compilation ou de l'installation."
            return 1
        }

        # Nettoyage
        cd ..
        rm -rf "$dossier" "$fichier"

        echo "Installation de $logiciel terminée."

        echo "Retourner au menu principal..."
        sleep 1
        source $SCRIPT_PATH/host_manager.sh
    fi

else
    echo "Impossible de détecter le système d'exploitation."
    source $SCRIPT_PATH/host_manager.sh
fi
