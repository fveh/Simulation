#!/bin/bash
# HTTP Flood Simulation
source ../config.cfg
source utils.sh

run_http_flood() {
    clear
    echo -e "${CYAN}Starting HTTP Flood Simulation (Localhost)...${NC}"
    echo -e "${YELLOW}Sending $HTTP_COUNT HTTP requests${NC}"
    
    # Start simple HTTP server if needed
    if ! pgrep -f "python -m http.server" > /dev/null; then
        echo -e "\n${GREEN}[+] Starting Python HTTP server...${NC}"
        python -m http.server $HTTP_PORT > /dev/null 2>&1 &
        sleep 2
    fi
    
    # Launch requests
    echo -e "\n${RED}[+] Flooding HTTP requests...${NC}"
    seq 1 $HTTP_COUNT | xargs -I{} -P 10 curl -s "http://$TARGET_IP:$HTTP_PORT" > /dev/null
    
    # Results
    echo -e "\n${GREEN}[+] Sent $HTTP_COUNT HTTP requests"
    echo -e "Server status:"
    netstat -an | grep $HTTP_PORT
    
    log_event "HTTP_Flood" "Requests:$HTTP_COUNT"
}

run_http_flood
read -p "Press Enter to return to main menu..."
