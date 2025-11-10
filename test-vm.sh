#!/bin/bash
# Testing helper script for fresh-mac installation
# This helps you set up a test environment and validate the installation

echo "=== Fresh Mac Testing Helper ==="
echo ""
echo "Choose your testing method:"
echo "1. Create UTM VM (macOS on Apple Silicon)"
echo "2. Create Tart VM (automated macOS VM)"
echo "3. Setup OrbStack Linux VM (partial testing)"
echo "4. Generate test validation checklist"
echo "5. Exit"
echo ""
read -p "Enter choice [1-5]: " choice

case $choice in
    1)
        echo "Setting up UTM VM..."
        if ! command -v utm &> /dev/null; then
            echo "Installing UTM..."
            brew install --cask utm
        fi
        echo ""
        echo "Manual steps:"
        echo "1. Download macOS installer with: softwareupdate --list-full-installers"
        echo "2. Create VM in UTM with 8GB+ RAM, 60GB+ disk"
        echo "3. Install macOS"
        echo "4. In the VM, run: git clone https://github.com/jamesacampbell/fresh-mac.git"
        echo "5. cd fresh-mac && python installer.py [your-phone]"
        ;;
    2)
        echo "Setting up Tart VM..."
        if ! command -v tart &> /dev/null; then
            echo "Installing Tart..."
            brew install cirruslabs/cli/tart
        fi
        echo "Available images:"
        tart list
        echo ""
        read -p "Enter macOS version to test (sonoma/ventura/sequoia): " version
        echo "Cloning macOS ${version} VM..."
        tart clone ghcr.io/cirruslabs/macos-${version}-vanilla:latest test-fresh-mac
        echo ""
        echo "Starting VM (this may take a few minutes)..."
        tart run test-fresh-mac &
        sleep 30
        VM_IP=$(tart ip test-fresh-mac)
        echo ""
        echo "VM is running at: ${VM_IP}"
        echo "SSH with: ssh admin@${VM_IP} (password: admin)"
        echo ""
        echo "In the VM, run:"
        echo "  git clone https://github.com/jamesacampbell/fresh-mac.git"
        echo "  cd fresh-mac && python installer.py 555-1234"
        ;;
    3)
        echo "Setting up OrbStack Linux VM for partial testing..."
        if ! command -v orbstack &> /dev/null; then
            echo "Installing OrbStack..."
            brew install --cask orbstack
        fi
        echo "Creating Ubuntu test VM..."
        orbstack create ubuntu fresh-mac-test
        echo ""
        echo "VM created. Testing bash script logic..."
        echo "Note: This won't test macOS-specific commands, but will test:"
        echo "  - Script structure and logic"
        echo "  - Dialog flows"
        echo "  - Conditional branches"
        echo ""
        echo "Connect with: orbstack shell fresh-mac-test"
        ;;
    4)
        echo ""
        echo "=== Fresh Mac Installation Test Checklist ==="
        echo ""
        echo "PRE-INSTALLATION:"
        echo "[ ] Fresh macOS installation (or VM)"
        echo "[ ] Internet connection working"
        echo "[ ] Admin privileges available"
        echo ""
        echo "DURING INSTALLATION:"
        echo "[ ] Xcode tools install prompt appears"
        echo "[ ] Homebrew installs successfully"
        echo "[ ] UV installs early in process"
        echo "[ ] Dialog box appears with 3 options"
        echo "[ ] Selected option (1=full, 2=lite) executes"
        echo ""
        echo "CORE FEATURES (both options):"
        echo "[ ] OrbStack installs"
        echo "[ ] Caddy installs"
        echo "[ ] Python libraries install via uv"
        echo "[ ] CLI tools install via uv tool"
        echo "[ ] Chromium installs"
        echo "[ ] iTerm2 installs"
        echo "[ ] Visual Studio Code installs"
        echo "[ ] dnscrypt-proxy installs and starts"
        echo "[ ] Firewall enables with stealth mode"
        echo "[ ] FileVault enables"
        echo "[ ] Dock clears"
        echo "[ ] Login message sets correctly"
        echo ""
        echo "BATTERIES INCLUDED (option 1 only):"
        echo "[ ] TOR installs and starts"
        echo "[ ] Privoxy installs and starts"
        echo "[ ] Nginx installs"
        echo "[ ] Node/NPM installs"
        echo "[ ] Rust installs"
        echo "[ ] Enhanced privacy dialog appears at end"
        echo "[ ] Privacy settings apply if accepted"
        echo ""
        echo "POST-INSTALLATION VERIFICATION:"
        echo "[ ] Run: brew --version"
        echo "[ ] Run: uv --version"
        echo "[ ] Run: orbstack --version"
        echo "[ ] Run: caddy version"
        echo "[ ] Run: python3 --version"
        echo "[ ] Run: uv tool list (shows installed tools)"
        echo "[ ] Check: sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate"
        echo "[ ] Check: sudo fdesetup status"
        echo "[ ] Verify zsh config applied: cat ~/.zshrc"
        echo ""
        echo "PRIVACY SETTINGS (if enabled):"
        echo "[ ] Verify Siri disabled: defaults read com.apple.assistant.support 'Assistant Enabled'"
        echo "[ ] Verify location off: defaults read /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd"
        echo "[ ] Check Safari settings: defaults read com.apple.Safari SendDoNotTrackHTTPHeader"
        echo ""
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "Testing helper complete!"

