#!/usr/bin/env bash

set -e
umask 022
clear
# Function to display the menu
echo -e "\033[0;36m██╗  ██╗███████╗██╗   ██╗██╗███╗   ██╗███████╗     █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗";
echo "██║ ██╔╝██╔════╝██║   ██║██║████╗  ██║██╔════╝    ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝";
echo "█████╔╝ █████╗  ██║   ██║██║██╔██╗ ██║███████╗    ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗  ";
echo "██╔═██╗ ██╔══╝  ╚██╗ ██╔╝██║██║╚██╗██║╚════██║    ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝  ";
echo "██║  ██╗███████╗ ╚████╔╝ ██║██║ ╚████║███████║    ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗";
echo "╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝╚══════╝    ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝";
echo "                                                                                                                ";
echo "███╗   ███╗ █████╗  ██████╗██████╗  ██████╗ ███████╗                                                            ";
echo "████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔════╝                                                            ";
echo "██╔████╔██║███████║██║     ██████╔╝██║   ██║███████╗                                                            ";
echo "██║╚██╔╝██║██╔══██║██║     ██╔══██╗██║   ██║╚════██║                                                            ";
echo "██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║╚██████╔╝███████║                                                            ";
echo -e "╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝\033[0m                                                           ";
show_menu() {
    echo "========================"
    echo "      Install Menu      "
    echo "========================"
    echo "1) Install Sequential Purging."
    echo -e "\033[0;31m2) Uninstall\033[0m"
    echo -e "\033[1;35mQ) Exit\033[0m"
    echo "========================"
}

# Function to handle the selection
run_choice() {
    case $1 in
        1)
            echo
            echo "Installing Sequential Purging..."
            echo
            echo -e "\033[1;31mCopying over config file..."
            cp ~/Kevins-Awesome-Macros/KAM-settings.cfg ~/printer_data/config/KAM-settings.cfg
            echo -e "\033[1;31mMaking KAM folder..."
            mkdir ~/printer_data/config/KAM/
            echo -e "\033[1;31mCreating symbolic link..."
            ln -s ~/Kevins-Awesome-Macros/sequential_purge/config/sequential_purge.cfg printer_data/config/KAM
            echo
            echo -e "\033[0;32mInstallation succesful!"
            echo
            read -n 1 -s -p $'\e[36mPress any key to continue...\e[0m ' key
            ;;
        2)  
            echo
            if [ ! -d "printer_data/config/KAM" ]; then
                echo "Kevin's Awesome Macro's already uninstalled"
            else
                while true; do
                    read -p $'\e[31mAre you sure? You will lose all your settings! [y/n]\e[0m: ' key
                    echo
                    if [[ $key == "Y" || $key == "y" ]]; then  # Check if the input is B or b
                        cd
                        echo -e "\033[1;31mDeleting KAM folder contents..."
                        rm printer_data/config/KAM/*
                        echo -e "\033[1;31mDeleting KAM folder..."
                        rmdir printer_data/config/KAM
                        echo -e "\033[1;31mDeleting KAM settings file..."
                        rm printer_data/config/KAM-settings.cfg || break
                        echo
                        echo -e "\033[0;32mDone uninstalling!"
                        break
                    else
                        echo -e "\033[0;32mFine!"
                        break
                    fi
                done
            fi
            echo
            read -n 1 -s -p $'\e[36mPress any key to continue...\e[0m ' key
            ;;
        Q | q)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option, please try again."
            echo
            read -n 1 -s -p $'\e[36mPress any key to continue...\e[0m ' key
            ;;
    esac
}

# Main loop
while true; do
    show_menu
    read -p $'\e[36mChoose an option: \e[0m' choice
    run_choice $choice
    echo
done
