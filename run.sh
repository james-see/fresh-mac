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
brew install dialog
brew analytics off
HEIGHT=12
WIDTH=45
CHOICE_HEIGHT=4
BACKTITLE="FRESH OSX - GET STARTED RIGHT BY JAMES CAMPBELL"
TITLE="INSTALL YOUR BASIC SETUP NOW"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install JC's OSX setup (batteries included)"
         2 "Install the lite core version with just the basics"
         3 "Quit now (too afraid)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
$full = false; # sensible default
$lighter = true; # sensible default
case $CHOICE in
        1)
            echo "You chose Option 1"
            $full = true;
            ;;
        2)
            echo "You chose Option 2"
            $lighter = true;
        3)
            echo "You chose Option 2, goodbye."
            exit
            ;;
esac
brew tap caskroom/cask
brew tap homebrew/services
if [ "$full" = true ] ; then
    echo "installing php70 with fpm and mysql"
    brew tap homebrew/dupes && \
    brew tap homebrew/php && \
    brew install --without-apache --with-fpm --with-mysql php70
    echo "installing nginx..."
    brew tap homebrew/nginx && \
    brew install nginx
    echo "making sites-available dirs..."
    mkdir -p /usr/local/etc/nginx/sites-available && \
    mkdir -p /usr/local/etc/nginx/sites-enabled && \
    mkdir -p /usr/local/etc/nginx/conf.d && \
    mkdir -p /usr/local/etc/nginx/ssl
    echo "installing task warrior"
    brew install task
    brew install taskd
    brew install tasksh
    echo "installing git..."
    brew install git
    echo "installing sublime text..."
    brew install Caskroom/cask/sublime-text
    brew install bash-completion
    echo "installing nodejs..."
    brew install node
    brew install npm
    echo "installing hgrep from npm..."
    npm install -g hgrep
    echo "installing charles..."
    brew install Caskroom/cask/charles
    echo "installing little snitch..."
    brew install Caskroom/cask/little-snitch
    echo "installing htop..."
    brew install htop
    echo "installing tmux..."
    brew install tmux
    echo "installing imagemagick..."
    brew install imagemagick
    echo "installing Panic's Coda..."
    brew install Caskroom/cask/coda
    echo "installing bartender..."
    brew install Caskroom/cask/bartender
fi
echo "installing iterm2..."
brew install Caskroom/cask/iterm2
echo "installing gpgtools..."
brew install Caskroom/cask/gpgtools
echo "installing zsh..."
brew install zsh --upgrade
echo "installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc-backup
cp configs/zshrc $HOME/.zshrc
echo "installing go..."
brew install go --upgrade
echo "installing python3..."
brew install python3 --upgrade
echo "installing fav fonts..."
cp fonts/*.ttf /Library/Fonts/
echo "installing Chromium..."
brew install Caskroom/cask/chromium
echo "installing etcher..."
brew install Caskroom/cask/etcher
echo "installing tunnelblick..."
brew install Caskroom/cask/tunnelblick
echo "installing all pip packages..."
cat requirements.txt | sudo xargs -n 1 pip3 install
echo "fixing DNS to encrypt all of your dns resolver lookups"   
brew install dnsmasq
brew install dnscrypt-proxy
echo "changing default screenshot location to ~/Documents/Screenshots"
mkdir $HOME/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer
echo "running osx lockdown checks..."
mkdir $HOME/projects
cd $HOME/projects
echo "turning on fulldisk encryption..."
sudo fdesetup enable
echo "evicting filevault keys from memory at sleep..."
sudo pmset -a destroyfvkeyonstandby 1
echo "enforcing hibernation..."
sudo pmset -a hibernatemode 25
echo "modifying standby and nap settings..."
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a standbydelay 0
sudo pmset -a autopoweroff 0
echo "enabling the firewall and stealth node..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
echo "turning off auto-allowing signed apps from popping through firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sudo pkill -HUP socketfilterfw
# git clone git@github.com:kristovatlas/osx-config-check.git osxlockdown
# cd osxlockdown
# python app.py
dialog --title "FINISHED" \
--msgbox "\n Installation Completed, Enjoy Your New System" 6 50
