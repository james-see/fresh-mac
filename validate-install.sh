#!/bin/bash
# Validation script to run AFTER fresh-mac installation
# This verifies that all components installed correctly

echo "=== Fresh Mac Installation Validator ==="
echo ""

ERRORS=0
WARNINGS=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $1 is NOT installed"
        ((ERRORS++))
        return 1
    fi
}

check_service() {
    if brew services list | grep -q "$1.*started"; then
        echo -e "${GREEN}✓${NC} $1 service is running"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $1 service is not running (may be optional)"
        ((WARNINGS++))
        return 1
    fi
}

check_default() {
    result=$(defaults read $1 $2 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1 $2 = $result"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $1 $2 not set (may be optional)"
        ((WARNINGS++))
        return 1
    fi
}

echo "CORE TOOLS:"
check_command brew
check_command uv
check_command python3
check_command zsh
check_command git
check_command go
check_command caddy
check_command code  # VSCode
check_command tree
check_command jq
check_command bat

echo ""
echo "UV TOOLS (checking uv tool list):"
uv tool list 2>/dev/null | head -10

echo ""
echo "CONTAINERS & VMS:"
if [ -d "/Applications/OrbStack.app" ]; then
    echo -e "${GREEN}✓${NC} OrbStack is installed"
else
    echo -e "${RED}✗${NC} OrbStack is NOT installed"
    ((ERRORS++))
fi

if [ -d "/Applications/UTM.app" ]; then
    echo -e "${GREEN}✓${NC} UTM is installed"
else
    echo -e "${RED}✗${NC} UTM is NOT installed"
    ((ERRORS++))
fi

echo ""
echo "SECURITY SETTINGS:"
FIREWALL=$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null | grep -q "enabled" && echo "enabled" || echo "disabled")
if [ "$FIREWALL" = "enabled" ]; then
    echo -e "${GREEN}✓${NC} Firewall is enabled"
else
    echo -e "${RED}✗${NC} Firewall is disabled"
    ((ERRORS++))
fi

STEALTH=$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode 2>/dev/null | grep -q "enabled" && echo "enabled" || echo "disabled")
if [ "$STEALTH" = "enabled" ]; then
    echo -e "${GREEN}✓${NC} Stealth mode is enabled"
else
    echo -e "${YELLOW}⚠${NC} Stealth mode is disabled"
    ((WARNINGS++))
fi

FV_STATUS=$(sudo fdesetup status 2>/dev/null)
if echo "$FV_STATUS" | grep -q "FileVault is On"; then
    echo -e "${GREEN}✓${NC} FileVault is enabled"
elif echo "$FV_STATUS" | grep -q "Encryption in progress"; then
    echo -e "${YELLOW}⚠${NC} FileVault encryption in progress"
else
    echo -e "${YELLOW}⚠${NC} FileVault may not be enabled (requires reboot)"
    ((WARNINGS++))
fi

echo ""
echo "POWER MANAGEMENT:"
POWERNAP=$(sudo pmset -g 2>/dev/null | grep powernap | head -1 | awk '{print $2}')
if [ "$POWERNAP" = "0" ]; then
    echo -e "${GREEN}✓${NC} Power Nap is disabled"
else
    echo -e "${YELLOW}⚠${NC} Power Nap setting: $POWERNAP"
fi

echo ""
echo "DOCK & UI:"
DOCK_APPS=$(defaults read com.apple.dock persistent-apps 2>/dev/null | grep -c "tile-data")
if [ "$DOCK_APPS" -lt 5 ]; then
    echo -e "${GREEN}✓${NC} Dock has been cleared ($DOCK_APPS items)"
else
    echo -e "${YELLOW}⚠${NC} Dock has $DOCK_APPS items (may not have been cleared)"
fi

echo ""
echo "PRIVACY SETTINGS (if enhanced privacy was enabled):"
SIRI=$(defaults read com.apple.assistant.support "Assistant Enabled" 2>/dev/null)
if [ "$SIRI" = "0" ]; then
    echo -e "${GREEN}✓${NC} Siri is disabled (enhanced privacy enabled)"
elif [ "$SIRI" = "1" ]; then
    echo "  Siri is enabled (enhanced privacy not enabled or skipped)"
fi

LOCATION=$(sudo defaults read /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled 2>/dev/null)
if [ "$LOCATION" = "0" ]; then
    echo -e "${GREEN}✓${NC} Location services disabled (enhanced privacy enabled)"
elif [ "$LOCATION" = "1" ]; then
    echo "  Location services enabled (enhanced privacy not enabled or skipped)"
fi

DNT=$(defaults read com.apple.Safari SendDoNotTrackHTTPHeader 2>/dev/null)
if [ "$DNT" = "1" ]; then
    echo -e "${GREEN}✓${NC} Safari Do Not Track enabled"
fi

echo ""
echo "ZSH CONFIGURATION:"
if [ -f "$HOME/.zshrc" ]; then
    echo -e "${GREEN}✓${NC} .zshrc exists"
    if grep -q "oh-my-zsh" "$HOME/.zshrc"; then
        echo -e "${GREEN}✓${NC} oh-my-zsh detected in .zshrc"
    fi
else
    echo -e "${RED}✗${NC} .zshrc not found"
    ((ERRORS++))
fi

echo ""
echo "==================================="
echo "SUMMARY:"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}Perfect! Everything installed correctly.${NC}"
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}Installation completed with $WARNINGS warnings.${NC}"
else
    echo -e "${RED}Installation had $ERRORS errors and $WARNINGS warnings.${NC}"
fi
echo "==================================="

exit $ERRORS

