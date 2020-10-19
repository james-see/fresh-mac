#!/bin/bash
echo "installing xcode tools..."
xcode-select --install
echo "checking and installing homebrew as necessary..."
if which brew 2>/dev/null; then
    echo "brew already installed, skipping..."
else
    echo "brew not found, installing now..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
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
brew tap homebrew/services
if [ "$full" = true ] ; then
    echo "installing nginx..."
    brew install nginx --HEAD
    echo "installing task warrior..."
    brew install task
    brew install taskd
    brew install tasksh
    echo "installing nodejs and npm and nvm..."
    brew install node
    brew install npm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
    echo "install ripgrep because it is 10x faster than grep..."
    brew install ripgrep
    echo "installing hgrep from npm to do nice etl parsing..."
    npm install -g hgrep
    echo "installing charles..."
    brew cask install charles
    echo "installing little snitch..."
    brew cask install little-snitch
    echo "installing htop..."
    brew install htop
    echo "installing tmux..."
    brew install tmux
    echo "installing imagemagick..."
    brew install imagemagick
    echo "installing Panic's Coda..."
    brew cask install coda
    echo "installing bartender..."
    brew cask install bartender
    echo "installing docker..."
    brew cask install docker
    echo "installing docker completions..."
    brew install bash-completion
    brew install docker-completion
    brew install docker-compose-completion
    brew install docker-machine-completion
    echo "installing virtualbox..."
    brew cask install virtualbox
    echo "now for some functional stuff, installing elixir..."
    brew install elixir
    echo "now installing elm..."
    brew install elm
    echo "now installing haskell via ghcup and haskellstack..."
    curl https://get-ghcup.haskell.org -sSf | sh
    curl -sSL https://get.haskellstack.org/ | sh
    echo "now installing spectacle window manager..."
    brew cask install spectacle
    echo "now installing vagrant and vagrant manager..."
    brew cask install vagrant
    brew cask install vagrant-manager
    echo "now installing vagrant-vbguest plugin..."
    vagrant plugin install vagrant-vbguest
    echo "now installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "now installing dust (du but better)..."
    cargo install du-dust
    echo "now installing pianobar (pandora radio from terminal)..."
    brew install pianobar
    echo "now installing gtime, better than time at timing processes..."
    brew install gtime
    echo "now installing glow, a nice markdown viewer for the cli..."
    brew install glow
    echo "now installing nb the terminal based notebook solution..."
    brew tap xwmx/taps
    brew install nb

fi
echo "Setting message for login screen..."
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Please call or text ${PHONE} for reward"
echo "Installing lib dependancies for python packages..."
brew install libxml2 libxslt
brew install libtiff libjpeg webp little-cms2
echo "installing tree for pretty trees directories..."
brew install tree
echo "install jq to display json in a pretty way..."
brew install jq
echo "installing bat as replacement for cat..."
brew install bat
echo "install exa as replacement for ls..."
brew install exa
echo "install mdcat to render markdown..."
brew install mdcat
echo "installing audio pre-requisites for pyAudio..."
brew install portaudio
brew link portaudio
echo "installing visual studio code"
brew cask install visual-studio-code
echo "install ruby version manager and rails..."
curl -sSL https://get.rvm.io | bash -s stable --rails
echo "installing nerd fonts..."
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
echo "installing iterm2..."
brew cask install iterm2
echo "installing gpgtools..."
brew cask install gpg-suite
echo "installing go..."
brew install go --HEAD
echo "installing python3..."
brew install python
echo "installing fav fonts..."
cp fonts/*.ttf /Library/Fonts/
echo "installing Chromium..."
brew cask install chromium
echo "installing defaultbrowser tool and setting default to Chromium..."
brew install defaultbrowser
defaultbrowser chromium
echo "installing etcher..."
brew cask install balenaetcher
echo "installing tunnelblick..."
brew cask install tunnelblick
echo "installing all pip packages..."
cat requirements.txt | sudo xargs -n 1 pip3 install
echo "fixing DNS to encrypt all of your dns resolver lookups"
brew install dnsmasq
brew install dnscrypt-proxy
sudo brew services start dnscrypt-proxy
brew install privoxy
brew services start privoxy
sudo networksetup -setwebproxy "Wi-Fi" 127.0.0.1 8118
echo "turning off captive control when searching for wifi networks"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
echo "changing default screenshot location to ~/Documents/Screenshots because desktop screenshots suck..."
mkdir $HOME/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer
echo "turning on fulldisk encryption..."
sudo fdesetup enable
echo "evicting filevault keys from memory at sleep..."
sudo pmset -a destroyfvkeyonstandby 1
echo "enforcing hibernation..."
sudo pmset -a hibernatemode 25
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
dialog --title "FINISHED" \
--msgbox "\n Installation Completed, Enjoy Your New System\nInstalling zsh as final step" 12 70
echo "installing zsh..."
brew install zsh --upgrade
echo "installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

