#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${YELLOW}>>> حذف الملفات والمجلدات غير الضرورية...${NC}"
sleep 2

if [ -d "/CONTROL" ]; then
    rm -rf "/CONTROL" >/dev/null 2>&1
    echo -e "${CYAN}✓ تم حذف /CONTROL${NC}"
fi

for dir in /control /postinst /preinst /prerm /postrm; do
    if [ -d "$dir" ]; then
        rm -rf "$dir" >/dev/null 2>&1
        echo -e "${CYAN}✓ تم حذف $dir${NC}"
    fi
done

rm -rf /tmp/*.ipk >/dev/null 2>&1
rm -rf /tmp/*.tar.gz >/dev/null 2>&1
echo -e "${GREEN}✓ تم تنظيف الملفات المؤقتة${NC}"
echo ""

plugin="translator"
version="1.4"
url="https://raw.githubusercontent.com/Ham-ahmed/312/refs/heads/main/translator_1.4.tar.gz"
package="/var/volatile/tmp/$plugin-$version.tar.gz"

echo -e "${YELLOW}>>> Downloading a package $plugin-$version ...${NC}"
sleep 2

if wget --show-progress -qO "$package" --no-check-certificate "$url"; then
    echo -e "${GREEN}✓ Downloaded successfully${NC}"
    echo -e "${CYAN}>>> Unzipping and installation in progress...${NC}"
    sleep 2
    
    if tar -xzf "$package" -C /; then
        rm -rf "$package" >/dev/null 2>&1
        echo -e "${GREEN}✓ Installation completed successfully${NC}"
        echo ""
        
        echo -e "${PURPLE}################################################################${NC}"
        echo -e "${CYAN}#       ${GREEN}Installation completed successfully${CYAN}       #${NC}"
        echo -e "${CYAN}#                  ${YELLOW}ON - Panel v6.5${CYAN}               #${NC}"
        echo -e "${CYAN}#         ${RED}Restarting Enigma2 is required${CYAN}            #${NC}"
        echo -e "${CYAN}#        .::${BLUE}UPLOADED BY >>> HAMDY_AHMED${CYAN}::.         #${NC}"
        echo -e "${CYAN}#   ${BLUE}https://www.facebook.com/share/g/18qCRuHz26/${CYAN}   #${NC}"
        echo -e "${PURPLE}################################################################${NC}"
        echo -e "${CYAN}#           ${YELLOW}The device will now restart${CYAN}          #${NC}"
        echo -e "${PURPLE}###########################################################33###${NC}"
        echo ""
        
        sleep 3
        echo -e "${RED}>>> Restarting...${NC}"
        sleep 2
        reboot
        
    else
        echo -e "${RED}✗ Failed to decompress package${NC}"
        rm -rf "$package" >/dev/null 2>&1
        exit 1
    fi
    
else
    echo -e "${RED}✗ Package download failed${NC}"
    echo -e "${YELLOW}>>> Please check your internet connection${NC}"
    exit 1
fi
