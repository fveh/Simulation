#!/bin/bash
# Main controller for DoS Educational Toolkit
# Strictly for localhost simulation only

# Load configuration and utilities
source config.cfg
source modules/utils.sh

# Initialize environment
init_setup() {
    clear
    echo -e "${RED}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    echo -e "${YELLOW}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    echo -e "${GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ EDUCATIONAL DoS SIMULATOR ▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    echo -e "${YELLOW}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    echo -e "${RED}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    
    check_root
    install_dependencies
    create_log_dir
}

# Main menu
show_menu() {
    while true; do
        clear
        echo -e "\n${CYAN}╔══════════════════════════════════════════╗"
        echo -e "║       ${BOLD}EDUCATIONAL DoS SIMULATOR${NC} ${CYAN}       ║"
        echo -e "╠══════════════════════════════════════════╣"
        echo -e "║  ${YELLOW}1.${NC}  SYN Flood Attack Simulation         ║"
        echo -e "║  ${YELLOW}2.${NC}  Slowloris Attack Simulation         ║"
        echo -e "║  ${YELLOW}3.${NC}  DNS Amplification Demo              ║"
        echo -e "║  ${YELLOW}4.${NC}  UDP Flood Simulation                ║"
        echo -e "║  ${YELLOW}5.${NC}  HTTP Flood Simulation               ║"
        echo -e "║  ${YELLOW}6.${NC}  ICMP Ping Flood                     ║"
        echo -e "║  ${YELLOW}7.${NC}  View Attack Logs                    ║"
        echo -e "║  ${YELLOW}8.${NC}  Legal Disclaimer                    ║"
        echo -e "║  ${YELLOW}9.${NC}  Exit                                ║"
        echo -e "╚══════════════════════════════════════════╝${NC}"
        
        read -p "Select an option [1-9]: " choice
        
        case $choice in
            1) source modules/syn_flood.sh ;;
            2) source modules/slowloris.sh ;;
            3) source modules/dns_amplification.sh ;;
            4) source modules/udp_flood.sh ;;
            5) source modules/http_flood.sh ;;
            6) source modules/icmp_flood.sh ;;
            7) view_logs ;;
            8) show_disclaimer ;;
            9) exit 0 ;;
            *) echo -e "${RED}Invalid option!${NC}"; sleep 1 ;;
        esac
    done
}

# Initialize and start
init_setup
show_menu
