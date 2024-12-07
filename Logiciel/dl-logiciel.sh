#!/usr/bin/env bash


dl_logiciel(){
    logiciel=$1
    source_url=$2

    if [ -z "$logiciel" ]; then
         echo "Erreur : Vous devez spécifier un logiciel à installer."
         echo "pour instalé un logiciel veuillez soit entrer : <nom_du_logiciel>  ou [url_du_fichier_source]"
         return 1
    fi

    if [ -f /etc/os-release ]; then
        # Identifier la distribution sur la quelle ont est 
        ./etc/os-release
        if [ -z "$source_url" ]; then
 # Installation depuis un dépôt
            case $ID in
                ubuntu|debian)
                    echo "Installation de $logiciel depuis le dépôt sur Debian/Ubuntu..."
                    sudo apt update && sudo apt install -y "$logiciel"
                ;;
                 rhel|centos|fedora)
                    echo "Installation de $logiciel depuis le dépôt sur RHEL/CentOS/Fedora..."
                    sudo dnf install -y "$logiciel" || sudo yum install -y "$logiciel"
                ;;
                arch|manjaro)
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
            dossier=$(basename "$fichier" .tar.gz)

# Télécharger la source
            wget "$source_url" -O "$fichier" || { echo "Échec du téléchargement."; return 1; }

# Extraire le fichier
            tar -xzf "$fichier" || { echo "Échec de l'extraction."; return 1; }

# Compilation et installation
            cd "$dossier" || { echo "Impossible d'accéder au dossier des sources."; return 1; }
            ./configure && make && sudo make install || { echo "Échec de la compilation ou de l'installation."; return 1; }

            echo "Installation de $logiciel terminée à partir des sources."
            echo ""
            echo "pour retournéee au menu "gestion des logiciel " entée 1 "
            read choix 
            if [ "$choix" -eq 1 ]; then 
                source sous_menu_logiciel.sh
            else
                echo "Choix invalide. Retour au menu principal..."
                source host-manager.sh
            fi
        fi 

    else
        echo "Impossible de détecter le système d'exploitation."
        source sous_menu_logiciel.sh
    fi
}