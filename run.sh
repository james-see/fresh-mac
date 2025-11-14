#!/bin/bash
echo "Granting Terminal necessary permissions for system modifications..."
echo "This will trigger a macOS permission prompt - please click 'Allow' when prompted."
# Reset Accessibility permissions for Terminal to trigger prompt early (if previously denied)
sudo tccutil reset Accessibility com.apple.Terminal 2>/dev/null || true
# Trigger permission prompt by attempting to control Dock (requires Accessibility permission)
# Using osascript to interact with Dock will trigger the prompt if not already granted
osascript -e 'tell application "System Events" to tell process "Dock" to get name of every window' >/dev/null 2>&1 || true
# Small delay to allow prompt to appear
sleep 2
echo "If you see a permission prompt above, please click 'Allow' to continue."
echo "Waiting 5 seconds for you to grant permissions..."
sleep 5
echo ""
echo "installing xcode tools..."
xcode-select --install
echo "checking and installing homebrew as necessary..."
if which brew 2>/dev/null; then
    echo "brew already installed, skipping..."
else
    echo "brew not found, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
    source ~/.zshrc
fi
echo "installing uv for modern Python package management..."
brew install uv
PHONE=${PHONE}
brew install dialog
brew analytics off
HEIGHT=12
WIDTH=55
CHOICE_HEIGHT=4
BACKTITLE="FRESH MAC - GET STARTED RIGHT BY JAMES CAMPBELL"
TITLE="INSTALL YOUR BASIC SETUP NOW"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install JC's MAC setup (batteries included)"
    2 "Install the lite version with just the basics"
3 "Quit now (too afraid?)")

CHOICE=$(dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "$TITLE" \
    --menu "$MENU" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
    "${OPTIONS[@]}" \
2>&1 >/dev/tty)

clear
full=false; # sensible default
lighter=true; # sensible default
case $CHOICE in
    1)
        echo "You chose Option 1, good for you!"
        full=true;
    ;;
    2)
        echo "You chose Option 2, the basics..."
        lighter=true;
    ;;
    3)
        echo "You chose Option 3, goodbye."
        exit
    ;;
esac
# Note: brew services is now built into Homebrew core, no tap needed
if [ "$full" = true ] ; then
    echo "installing tor and privoxy for privacy..."
    brew install tor
    brew install privoxy
    brew services start tor
    brew services start privoxy
    sudo networksetup -setwebproxy "Wi-Fi" 127.0.0.1 8118
    echo "installing nginx..."
    brew install nginx --HEAD
    echo "installing task warrior..."
    brew install task
    brew install taskd
    brew install tasksh
    echo "installing wget..."
    brew install wget
    echo "installing nodejs and npm and nvm..."
    brew install node
    brew install npm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    echo "install ripgrep because it is 10x faster than grep..."
    brew install ripgrep
    echo "installing hgrep from npm to do nice etl parsing..."
    npm install -g hgrep
    echo "installing charles..."
    brew install charles
    echo "installing little snitch..."
    brew install little-snitch
    echo "installing htop..."
    brew install htop
    echo "installing tmux..."
    brew install tmux
    echo "installing imagemagick..."
    brew install imagemagick
    echo "installing Objective See's Lulu..."
    brew install lulu
    echo "installing bartender..."
    brew install bartender
    echo "installing tidy-viewer csv viewer..."
    brew install tidy-viewer
    echo "installing viddy..."
    brew install viddy
    echo "installing gradle and openjdk..."
    brew install gradle openjdk
    echo "installing SDKMAN! for managing Java/JVM SDKs..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    echo "now for some functional stuff, installing elixir..."
    brew install elixir
    echo "now installing elm..."
    brew install elm
    echo "now installing haskell via ghcup and haskellstack..."
    curl https://get-ghcup.haskell.org -sSf | sh
    curl -sSL https://get.haskellstack.org/ | sh
    echo "now installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "now installing dust (du but better)..."
    cargo install du-dust
    echo "now installing pianobar (pandora radio from terminal)..."
    brew install pianobar
    echo "now installing glow, a nice markdown viewer for the cli..."
    brew install glow
    echo "now installing nb the terminal based notebook solution..."
    brew tap xwmx/taps
    brew install nb
    echo "install w3m, terminal based browser..."
    brew install w3m
    echo "installing duckdb amazing csv explorer..."
    brew install duckdb
    echo "now installing JamWifi..."
    wget http://macheads101.com/pages/downloads/mac/JamWiFi.app.zip
    unzip JamWifi.app.zip
    mv JamWifi.app /Applications
    echo "now installing Bluetility https://github.com/jnross/Bluetility..."
    brew install bluetility
    echo "removing extra clients as necessary..."
    sudo rm -rf OpenDNS\ Roaming\ Client
    sudo rm -rf OPSWAT\ GEARS\ Client
    echo "now installing rainbowstream Twitter terminal client..."
    uv tool install rainbowstream
    echo "now installing reddix, Reddit terminal client..."
    brew install reddix
    echo "now installing mcat, terminal image/video/markdown viewer..."
    brew install mcat
    echo "now installing slack-term, terminal client for Slack..."
    # must go here https://github.com/erroneousboat/slack-term/wiki#running-slack-term-without-legacy-tokens to get token
    brew install slack-term
    echo "now installing spotify terminal client..."
    brew install spotify-tui
    # must ensure you create an app at developer.spotify.com
    echo "now install spotify server"
    # must add this https://spotifyd.github.io/spotifyd/config/File.html as spotifyd.conf
    brew install spotifyd
    # must add two lines to zshrc to get pure to be prompt
    echo "installing pure prompt for zsh..."
    brew install pure
    echo "installing Raycast (modern Spotlight replacement)..."
    brew install --cask raycast
    echo "installing Warp (modern terminal with AI)..."
    brew install --cask warp
    echo "installing Ghostty (fast terminal)..."
    brew install --cask ghostty
    echo "installing Tailscale (easy VPN mesh networking)..."
    brew install --cask tailscale
    echo "installing 1Password CLI..."
    brew install --cask 1password-cli
fi
echo "installing OrbStack (modern Docker Desktop alternative)..."
brew install --cask orbstack
echo "installing UTM (virtual machine manager)..."
brew install --cask utm
echo "installing Caddy web server..."
brew install caddy
echo "Configuring Dock settings..."
# Enable auto-hide dock
defaults write com.apple.dock autohide -bool true
# Remove all apps from dock
defaults write com.apple.dock persistent-apps -array
# Disable hot corners that might interfere
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0
# Disable click wallpaper to reveal desktop (macOS Sonoma+) - try multiple methods
defaults write com.apple.dock click-to-reveal-desktop -bool false 2>/dev/null || true
# Disable Stage Manager desktop reveal (macOS Ventura/Sonoma+)
defaults write com.apple.WindowManager click-to-reveal-desktop -bool false 2>/dev/null || true
# Alternative method for disabling desktop reveal on click
defaults write com.apple.dock showDesktopOnClick -bool false 2>/dev/null || true
echo "Resetting dock..."
killall Dock
echo "Installing jpeg optim..."
brew install jpegoptim
echo "Installing rectangle window manager via shortcut keys (spectacle replacement)..."
brew install --cask rectangle
echo "Setting message for login screen..."
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Please call or text ${PHONE} for reward"
echo "Installing lib dependancies for python packages..."
brew install libxml2 libxslt
brew install libtiff libjpeg webp little-cms2
echo "installing pyenv for Python version management..."
brew install pyenv
# Install Python 3.12 LTS (current LTS, supported until Oct 2028)
echo "installing Python 3.12 LTS via pyenv..."
# pyenv will be available after shell restart, but we can set it up now
if command -v pyenv &> /dev/null || [ -d "$HOME/.pyenv" ]; then
    eval "$(pyenv init -)" 2>/dev/null || true
    pyenv install 3.12 --skip-existing 2>/dev/null || \
    echo "Python 3.12 will be installed when you run: pyenv install 3.12"
    pyenv global 3.12 2>/dev/null || true
else
    echo "Note: After installation, run 'pyenv install 3.12' to install Python 3.12 LTS"
fi
echo "installing GPG command line tools (needed for RVM)..."
brew install gnupg
echo "installing Ruby/RVM build dependencies..."
# RVM/Ruby compilation requires these dependencies
brew install autoconf automake libtool pkg-config
brew install readline libyaml libffi
# Ensure OpenSSL is available for Ruby (already installed earlier)
brew install zlib
echo "installing tree for pretty trees directories..."
brew install tree
echo "install jq to display json in a pretty way..."
brew install jq
echo "installing bat as replacement for cat..."
brew install bat
echo "installing jrnl, simple notetaking tool..."
brew install jrnl
echo "install mdcat to render markdown..."
brew install mdcat
echo "installing audio pre-requisites for pyAudio..."
brew install portaudio
brew link portaudio
echo "installing visual studio code"
brew install visual-studio-code
echo "installing Cursor IDE..."
# Cursor doesn't have an official Homebrew cask, so we install via DMG
TMP_DIR=$(mktemp -d)
ORIG_DIR=$(pwd)
cd "$TMP_DIR" || { echo "Warning: Could not change to temp directory"; rmdir "$TMP_DIR" 2>/dev/null || true; }
if [ -d "$TMP_DIR" ] && [ "$(pwd)" = "$TMP_DIR" ]; then
    curl -L -o Cursor.dmg "https://www.cursor.com/downloads/latest/mac" 2>/dev/null || curl -L -o Cursor.dmg "https://downloader.cursor.sh/mac" 2>/dev/null
    if [ -f Cursor.dmg ]; then
        hdiutil attach Cursor.dmg -quiet -nobrowse 2>/dev/null || true
        sleep 2
        if [ -d "/Volumes/Cursor/Cursor.app" ]; then
            cp -R "/Volumes/Cursor/Cursor.app" /Applications/ 2>/dev/null || true
            hdiutil detach "/Volumes/Cursor" -quiet 2>/dev/null || true
            echo "Cursor IDE installed successfully"
        else
            echo "Warning: Could not find Cursor.app in DMG"
        fi
        rm -f Cursor.dmg
    else
        echo "Warning: Could not download Cursor IDE DMG"
    fi
    cd "$ORIG_DIR" || true
    rmdir "$TMP_DIR" 2>/dev/null || true
fi
echo "install ruby version manager and rails..."
# Configure environment for RVM/Ruby compilation BEFORE installing RVM
# Determine Homebrew prefix (Apple Silicon vs Intel)
HOMEBREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/usr/local")
OPENSSL_PREFIX=$(brew --prefix openssl@3 2>/dev/null || echo "$HOMEBREW_PREFIX/opt/openssl@3")
# Set up build environment variables for Ruby compilation
export PATH="$OPENSSL_PREFIX/bin:$PATH"
export LDFLAGS="-L$OPENSSL_PREFIX/lib ${LDFLAGS:-}"
export CPPFLAGS="-I$OPENSSL_PREFIX/include ${CPPFLAGS:-}"
export PKG_CONFIG_PATH="$OPENSSL_PREFIX/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
# Also add readline, zlib, libyaml paths
READLINE_PREFIX=$(brew --prefix readline 2>/dev/null || echo "$HOMEBREW_PREFIX/opt/readline")
ZLIB_PREFIX=$(brew --prefix zlib 2>/dev/null || echo "$HOMEBREW_PREFIX/opt/zlib")
LIBYAML_PREFIX=$(brew --prefix libyaml 2>/dev/null || echo "$HOMEBREW_PREFIX/opt/libyaml")
export LDFLAGS="-L$READLINE_PREFIX/lib -L$ZLIB_PREFIX/lib -L$LIBYAML_PREFIX/lib $LDFLAGS"
export CPPFLAGS="-I$READLINE_PREFIX/include -I$ZLIB_PREFIX/include -I$LIBYAML_PREFIX/include $CPPFLAGS"
# Install RVM (GPG should already be installed)
curl -sSL https://get.rvm.io | bash -s stable
# Configure RVM to use OpenSSL 3 for Ruby compilation
if [ -d "$HOME/.rvm" ]; then
    echo "Configuring RVM to use OpenSSL 3..."
    # Create RVM config to use OpenSSL 3
    mkdir -p "$HOME/.rvm/user"
    echo "rvm_configure_flags+=(--with-openssl-dir=$OPENSSL_PREFIX)" > "$HOME/.rvm/user/db"
    echo "RVM installed successfully. Ruby installation will use OpenSSL 3."
    echo "Note: Ruby will be installed when you open a new terminal or run: rvm install ruby --latest"
else
    echo "Warning: RVM installation may have failed."
fi
echo "installing nerd fonts..."
# homebrew/cask-fonts was deprecated, fonts are now in homebrew/cask-fonts or use direct install
brew install --cask font-hack-nerd-font 2>/dev/null || \
brew tap homebrew/cask-fonts 2>/dev/null || true
brew install --cask font-hack-nerd-font 2>/dev/null || \
echo "Warning: Could not install font-hack-nerd-font via Homebrew. Fonts will be installed from local fonts directory."
echo "installing iterm2..."
brew install iterm2
echo "installing go..."
brew install go --HEAD
echo "installing fav fonts..."
cp fonts/*.ttf /Library/Fonts/
echo "installing Dia browser (AI-powered browser from The Browser Company)..."
brew install --cask thebrowsercompany-dia
echo "installing Brave..."
brew install --cask brave-browser
echo "installing defaultbrowser tool and setting default to Dia..."
brew install defaultbrowser
defaultbrowser dia
echo "installing etcher..."
brew install balenaetcher
echo "installing signal..."
brew install signal
echo "installing CLI tools via uv tool (isolated like pipx)..."
while IFS= read -r tool; do
    [[ -z "$tool" || "$tool" =~ ^# ]] && continue
    echo "Installing tool: $tool"
    uv tool install "$tool"
done < requirements-tools.txt
echo "installing Python libraries via uv pip..."
uv pip install -r requirements-libs.txt --system
echo "installing latest OpenSSL..."
brew install openssl@3
# Link OpenSSL to make it available system-wide
brew link --force openssl@3 2>/dev/null || true
echo "fixing DNS to encrypt all of your dns resolver lookups"
# Install dnscrypt-proxy for DNSCrypt encryption (primary DNS encryption)
brew install dnscrypt-proxy
# Install cloudflared for DNS-over-HTTPS (DoH) support
echo "installing cloudflared for DNS-over-HTTPS (DoH)..."
brew install cloudflare/cloudflare/cloudflared
# Configure cloudflared for DoH (runs on port 5054, backup/alternative to dnscrypt-proxy)
sudo mkdir -p /etc/cloudflared
sudo tee /etc/cloudflared/config.yaml > /dev/null <<EOF
proxy-dns: true
proxy-dns-port: 5054
proxy-dns-address: 127.0.0.1
proxy-dns-upstream:
  - https://1.1.1.1/dns-query
  - https://1.0.0.1/dns-query
  - https://2606:4700:4700::1111/dns-query
  - https://2606:4700:4700::1001/dns-query
EOF
# Install cloudflared as a service
sudo cloudflared service install 2>/dev/null || true
sudo brew services start cloudflared 2>/dev/null || true
sudo brew services start dnscrypt-proxy
# Configure system to use local DNS proxy (dnscrypt-proxy on 127.0.0.1)
# Get primary network interface
PRIMARY_INTERFACE=$(networksetup -listallnetworkservices | grep -E "^(Wi-Fi|Ethernet)" | head -n1 | sed 's/.*: //' || echo "Wi-Fi")
if [ -n "$PRIMARY_INTERFACE" ]; then
    echo "Configuring DNS for $PRIMARY_INTERFACE to use encrypted DNS..."
    sudo networksetup -setdnsservers "$PRIMARY_INTERFACE" 127.0.0.1 2>/dev/null || true
fi
echo "turning off captive control when searching for wifi networks"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
echo "changing default screenshot location to ~/Documents/Screenshots because desktop screenshots suck..."
mkdir "$HOME"/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer
echo "turning on fulldisk encryption..."
sudo fdesetup enable
echo "evicting filevault keys from memory at sleep..."
sudo pmset -a destroyfvkeyonstandby 1
echo "enforcing hibernation..."
sudo pmset -a hibernatemode 3
echo "changing autohide speed to instant for the dock..."
defaults write com.apple.dock autohide-delay -float 0.0001
killall Dock
echo "modifying standby and nap settings, turning off powernap etc..."
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a standbydelay 0
sudo pmset -a autopoweroff 0
echo "enabling the firewall and stealth node..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
echo "removing any personalized user photo..."
sudo dscl . delete /Users/$USER jpegphoto
echo "turning off auto-allowing signed apps from popping through firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sudo pkill -HUP socketfilterfw
if [ "$full" = true ] ; then
    PRIVACY_CHOICE=$(dialog --clear \
        --backtitle "FRESH MAC - ENHANCED PRIVACY SETTINGS" \
        --title "OPTIONAL ENHANCED PRIVACY" \
        --yesno "Do you want to enable enhanced privacy settings?\n\nThis will:\n- Disable analytics & crash reporting to Apple\n- Disable Siri & Spotlight suggestions\n- Disable Handoff & Continuity\n- Block Safari cookies & enable Do Not Track\n- Disable location services\n- Disable Bonjour advertising\n- Enable advanced fingerprinting protection\n\nNote: Some features may be affected." \
        18 70 \
    2>&1 >/dev/tty)
    
    if [ $? -eq 0 ]; then
        echo "Applying enhanced privacy settings..."
        
        echo "Disabling diagnostic data sending to Apple..."
        sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false
        sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist ThirdPartyDataSubmit -bool false
        
        echo "Disabling personalized ads..."
        defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
        
        echo "Disabling Siri..."
        defaults write com.apple.assistant.support "Assistant Enabled" -bool false
        
        echo "Disabling Siri suggestions in Spotlight..."
        defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true
        
        echo "Disabling Spotlight Suggestions in Safari..."
        defaults write com.apple.safari UniversalSearchEnabled -bool false
        defaults write com.apple.safari SuppressSearchSuggestions -bool true
        
        echo "Disabling Handoff and Continuity features..."
        defaults -currentHost write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false
        defaults -currentHost write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool false
        
        echo "Disabling AirDrop discovery..."
        defaults write com.apple.NetworkBrowser DisableAirDrop -bool true
        
        echo "Applying Safari privacy enhancements..."
        defaults write com.apple.Safari BlockStoragePolicy -int 2
        defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
        defaults write com.apple.Safari AutoFillPasswords -bool false
        defaults write com.apple.Safari AutoFillCreditCardData -bool false
        defaults write com.apple.Safari AdvancedFingerprintingProtection -bool true
        
        echo "Disabling location services..."
        sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 0
        
        echo "Disabling Bonjour multicast advertising..."
        sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
        
        echo "Clearing saved Wi-Fi networks..."
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.airport.preferences RememberedNetworks -array
        
        echo "Disabling QuickLook remote content..."
        defaults write com.apple.QuickLookDaemon QLRemoteContentAllowed -bool false
        
        echo "Disabling automatic software update checks..."
        sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
        
        echo "Disabling clipboard history in Spotlight..."
        defaults write com.apple.Spotlight ShowClipboardHistory -bool false
        
        echo "Enhanced privacy settings applied!"
    else
        echo "Skipping enhanced privacy settings."
    fi
fi
dialog --title "FINISHED" \
--msgbox "\n Installation Completed, Enjoy Your New System\nInstalling zsh as final step" 12 70
echo "installing zsh..."
brew install zsh --upgrade
echo "installing ohmyzsh (non-interactive)..."
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "oh-my-zsh installed, shell will be changed after config copy"

