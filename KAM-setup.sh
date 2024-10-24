#!/usr/bin/env bash
#!/bin/bash

# Text Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bold Text Colors
BOLD_BLACK='\033[1;30m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

# Background Colors
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'
BG_GREY='\033[0;100m'

GREY='\033[0;90m'
BOLD_GREY='\033[1;90m'
# Reset color
RESET='\033[0m'

set -e
umask 022
clear
# Function to display the menu
echo -e "${BOLD_WHITE}██╗  ██╗███████╗██╗   ██╗██╗███╗   ██╗███████╗                ";
echo "██║ ██╔╝██╔════╝██║   ██║██║████╗  ██║██╔════╝                ";
echo "█████╔╝ █████╗  ██║   ██║██║██╔██╗ ██║███████╗                ";
echo "██╔═██╗ ██╔══╝  ╚██╗ ██╔╝██║██║╚██╗██║╚════██║                ";
echo "██║  ██╗███████╗ ╚████╔╝ ██║██║ ╚████║███████║                ";
echo "╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝╚══════╝                ";
echo "                                                              ";
echo " █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗";
echo "██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝";
echo "███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗  ";
echo "██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝  ";
echo "██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗";
echo "╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝";
echo "                                                              ";
echo "███╗   ███╗ █████╗  ██████╗██████╗  ██████╗ ███████╗          ";
echo "████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔════╝          ";
echo "██╔████╔██║███████║██║     ██████╔╝██║   ██║███████╗          ";
echo "██║╚██╔╝██║██╔══██║██║     ██╔══██╗██║   ██║╚════██║          ";
echo "██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║╚██████╔╝███████║          ";
echo -e "╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝${RESET}";

show_menu() {
    echo "========================"
    echo "      Install Menu      "
    echo "========================"
    echo -e "${BOLD_WHITE}1) Install Sequential Purging"
    empty_line
    echo -e "${BOLD_CYAN}8) Update ${RESET}"
    echo -e "${BOLD_RED}9) Uninstall${RESET}"
    empty_line
    echo -e "${BOLD_WHITE}Q) Exit${RESET}"
    echo "========================"
}

# Function to handle the selection
run_choice() {
    case $1 in
        1)
            install_sequential_purging
        ;;
        8)
            update_KAM
        ;;
        9)
            empty_line
            if [ ! -d "printer_data/config/KAM" ]; then
                echo -e "${WHITE}Kevin's Awesome Macro's is already uninstalled.${RESET}"
            else
                while true; do
                    read -p '\e[1;31mAre you sure? You will lose all your settings! [y/n]\e[0m: ' key
                    if [[ $key == "Y" || $key == "y" ]]; then  # Check if the input is B or b
                        uninstall_KAM
                        break
                    else
                        echo -e "${GREEN}Fine!"
                        break
                    fi
                done
            fi
            empty_line
            read -n 1 -s -p $'\e[1;36mPress any key to continue...\e[0m ' key
        ;;
        Q | q)
            empty_line
            echo -e "${BOLD_RED}Exiting..."
            exit 0
        ;;
        *)
            echo "Invalid option, please try again."
            empty_line
            read -n 1 -s -p $'\e[1;36mPress any key to continue...\e[0m ' key
        ;;
    esac
}

uninstall_KAM() {
    cd
    echo -e "\033[1;31mDeleting KAM folder contents..."
    rm printer_data/config/KAM/*
    echo -e "\033[1;31mDeleting KAM folder..."
    rmdir printer_data/config/KAM
    echo -e "\033[1;31mDeleting KAM settings file..."
    rm printer_data/config/KAM-settings.cfg || break
    empty_line
    echo -e "\033[0;32mDone uninstalling!"
}

install_sequential_purging() {
    empty_line
    echo -e "${BOLD_PINK}Installing Sequential Purging...${RESET}"
    echo -e "${BOLD_RED}DO NOT TURN OF THE MACHINE!${RESET}"
    empty_line
    if [ ! -d "printer_data/config/KAM-settings.cfg" ]; then
        echo -e "${BOLD_WHITE}Copying over config file...${RESET}"
        cp ~/Kevins-Awesome-Macros/KAM-settings.cfg ~/printer_data/config/KAM-settings.cfg
        empty_line
    else
        echo -e "${BOLD_WHITE}Config file already exists. Skipping...${RESET}"
        empty_line
    fi
    if [ ! -d "printer_data/config/KAM" ]; then
        echo -e "${BOLD_WHITE}Making KAM folder...${RESET}"
        mkdir ~/printer_data/config/KAM/
        echo -e "${BOLD_WHITE}Creating symbolic link...${RESET}"
        ln -s ~/Kevins-Awesome-Macros/sequential_purge/config/sequential_purge.cfg printer_data/config/KAM
        empty_line
    else
        echo -e "${BOLD_WHITE}KAM folder already exists. Skipping...${RESET}"
        empty_line
    fi
    echo -e "${BOLD_GREEN}Installation succesful!${RESET}"
    empty_line
    echo -e "${BOLD_PURPLE}For documentation go to https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purge#installation${RESET}"
    empty_line
    read -n 1 -s -p $'\e[1;36mPress any key to continue...\e[0m ' key
}

update_KAM () {
    empty_line
    echo -e "${BOLD_PURPLE}Updating KAM...${RESET}"
    empty_line
    git reset --hard && git pull
    empty_line
    echo -e "${BOLD_GREEN}Update succesful!\e[0m"
    empty_line
    read -n 1 -s -p $'\e[1;36mPress any key to continue...\e[0m ' key
}

empty_line () {
    echo
}
# Main loop
while true; do
    show_menu
    read -p $'\e[36mChoose an option: \e[0m' choice
    run_choice $choice
    empty_line
done
