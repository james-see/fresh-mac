#!/bin/bash
echo "installing xcode tools..."
xcode-select --install
echo "installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install dialog
HEIGHT=12
WIDTH=45
CHOICE_HEIGHT=4
BACKTITLE="FRESH OSX - GET STARTED RIGHT BY JAMES CAMPBELL"
TITLE="INSTALL YOUR BASIC SETUP NOW"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install JC's default OSX setup"
         2 "Quit now (too afraid)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2, goodbye."
            exit
            ;;
esac
brew tap caskroom/cask
brew tap homebrew/services
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
echo "installing unetbootin..."
brew install Caskroom/cask/unetbootin
echo "installing nodejs..."
brew install node
brew install npm
echo "installing htop..."
brew install htop
echo "installing tmux..."
brew install tmux
echo "installing tunnelblick..."
brew install Caskroom/cask/tunnelblick
echo "installing bartender..."
brew install Caskroom/cask/bartender
echo "installing all pip packages..."
cat requirements.txt | sudo xargs -n 1 pip3 install
echo "running osx lockdown checks..."
mkdir $HOME/projects
cd $HOME/projects
git clone git@github.com:kristovatlas/osx-config-check.git osxlockdown
cd osxlockdown
python app.py
dialog --title "FINISHED" \
--msgbox "\n Installation Completed, Enjoy Your New System" 6 50
