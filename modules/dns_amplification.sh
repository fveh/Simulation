#!/bin/bash
# DNS Amplification Demo
source ../config.cfg
source utils.sh

run_dns_amp_demo() {
    clear
    echo -e "${CYAN}DNS Amplification Educational Demo${NC}"
    
    # Legitimate query
    echo -e "\n${GREEN}[+] Normal DNS query size:${NC}"
    dns_query="dig +short $TEST_DOMAIN @$DNS_SERVER"
    echo "Command: $dns_query"
    /data/data/com.termux/files/usr/bin/time -f "Size: %K KB" $dns_query >/dev/null
    
    # Malicious pattern
    echo -e "\n${RED}[+] Malicious amplification pattern:${NC}"
    amp_query="dig +short ANY $TEST_DOMAIN @$DNS_SERVER"
    echo "Command: $amp_query"
    /data/data/com.termux/files/usr/bin/time -f "Size: %K KB" $amp_query >/dev/null
    
    # Explanation
    echo -e "\n${YELLOW}╔════════════════════════════════════════════╗"
    echo -e "║ ${BOLD}How Amplification Works:${NC}                     ║"
    echo -e "╠════════════════════════════════════════════╣"
    echo -e "║ 1. Attacker sends small request with       ║"
    echo -e "║    spoofed victim IP (60 bytes)            ║"
    echo -e "║ 2. DNS responds with large response        ║"
    echo -e "║    (3000-4000 bytes)                       ║"
    echo -e "║ 3. Amplification factor: 50-100x           ║"
    echo -e "║ 4. Using botnets increases impact          ║"
    echo -e "╚════════════════════════════════════════════╝${NC}"
    
    log_event "DNS_Amplification" "Demo"
}

run_dns_amp_demo
read -p "Press Enter to continue..."
