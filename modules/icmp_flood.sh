#!/bin/bash
# ICMP Ping Flood
source ../config.cfg
source utils.sh

run_icmp_flood() {
    clear
    echo -e "${CYAN}Starting ICMP Ping Flood (Localhost)...${NC}"
    echo -e "${YELLOW}Sending $ICMP_COUNT ICMP packets${NC}"
    
    # Before
    echo -e "\n${GREEN}[+] Network status before:${NC}"
    ifconfig lo | grep 'RX packets'
    
    # Flood
    echo -e "\n${RED}[+] Sending ICMP packets...${NC}"
    ping -c $ICMP_COUNT $TARGET_IP > /dev/null 2>&1
    
    # Results
    echo -e "\n${GREEN}[+] Sent $ICMP_COUNT ICMP packets"
    ifconfig lo | grep 'RX packets'
    
    log_event "ICMP_Flood" "Packets:$ICMP_COUNT"
}

run_icmp_flood
read -p "Press Enter to return to main menu..."
