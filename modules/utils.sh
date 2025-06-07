#!/bin/bash
# Common utilities module

# Check root access
check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        echo -e "${RED}WARNING: Running as root!${NC}"
        read -p "Continue? [y/N] " -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Install dependencies
install_dependencies() {
    if ! command -v hping3 &> /dev/null || \
       ! command -v nmap &> /dev/null || \
       ! command -v curl &> /dev/null; then
        echo -e "${YELLOW}Installing dependencies...${NC}"
        pkg update -y
        pkg install -y hping3 nmap python curl dnsutils
    fi
}

# Create log directory
create_log_dir() {
    if [ ! -d "logs" ]; then
        mkdir logs
    fi
}

# Log simulation event
log_event() {
    local attack_type=$1
    local params=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $attack_type | $params" >> logs/simulations.log
}

# View logs
view_logs() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════╗"
    echo -e "║          ${BOLD}ATTACK SIMULATION LOGS${NC} ${CYAN}         ║"
    echo -e "╠══════════════════════════════════════════╣"
    
    if [ -f "logs/simulations.log" ]; then
        column -t -s '|' logs/simulations.log | \
        awk '{print "║ " $0 " ║"}'
    else
        echo -e "║       ${YELLOW}No logs available yet${NC}               ║"
    fi
    
    echo -e "╚══════════════════════════════════════════╝${NC}"
    read -p "Press Enter to continue..."
}

# Display disclaimer
show_disclaimer() {
    clear
    echo -e "${RED}╔══════════════════════════════════════════════════╗"
    echo -e "║ ${BOLD}LEGAL DISCLAIMER AND WARNING${NC} ${RED}                     ║"
    echo -e "╠══════════════════════════════════════════════════╣"
    echo -e "║ This tool is for EDUCATIONAL PURPOSES ONLY!      ║"
    echo -e "║ Unauthorized network attacks are ILLEGAL.        ║"
    echo -e "║                                                  ║"
    echo -e "║ All simulations target ONLY localhost (127.0.0.1)║"
    echo -e "║                                                  ║"
    echo -e "║ Never test without explicit written permission   ║"
    echo -e "║ Violators may face criminal charges under:       ║"
    echo -e "║   - Computer Fraud and Abuse Act (CFAA)          ║"
    echo -e "║   - Computer Misuse Act 1990 (UK)                ║"
    echo -e "║   - EU Directive 2013/40/EU                      ║"
    echo -e "╚══════════════════════════════════════════════════╝${NC}"
    echo -e "\n${BOLD}By using this tool, you agree:${NC}"
    echo "1. You will NOT use this for illegal purposes"
    echo "2. All testing is limited to your own systems"
    echo "3. You understand cybersecurity risks involved"
    read -p "Press Enter to acknowledge and continue..."
}
