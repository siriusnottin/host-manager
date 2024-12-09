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

        # Vérification de l'existence du fichier
        if [[ ! -f $source_url ]]; then
            echo "Erreur : Le fichier $source_url n'existe pas."
            exit 1
        fi  

           case $file_path in
            *.deb)
                echo "Installation d'un fichier .deb..."
                sudo apt install -y "$file_path" || sudo dpkg -i "$file_path"
                sudo apt --fix-broken install -y # Résolution des dépendances si nécessaire
                ;;
            *.rpm)
                echo "Installation d'un fichier .rpm..."
                if command -v dnf &>/dev/null; then
                    sudo dnf install -y "$file_path"
                elif command -v rpm &>/dev/null; then
                    sudo rpm -ivh "$file_path"
                else
                    echo "Aucun gestionnaire RPM (dnf/rpm) trouvé."
                    exit 1
                fi
                ;;
            *.sh)
                echo "Installation depuis un script bash..."
                chmod +x "$file_path"
                sudo "$file_path"
                ;;
            *)
                echo "Type de fichier non pris en charge ou inconnu."
                ;;
            esac

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
