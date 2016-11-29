#!/bin/bash
echo "installing xcode tools..."
xcode-select --install
echo "installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install dialog
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="FRESH OSX"
TITLE="INSTALL YOUR BASIC APPS AND CONFIGS AUTOMATICALLY"
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
echo "installing php70 with fpm and mysql"
brew tap homebrew/dupes && \
  brew tap homebrew/php && \
  brew install --without-apache --with-fpm --with-mysql php70
echo "installing git..."
brew install git
echo "installing cask..."
brew tap caskroom/cask
brew tap homebrew/services
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
cp ../assets/zshrc $HOME/.zshrc
echo "installing go..."
brew install go --upgrade
echo "installing python3..."
brew install python3 --upgrade
echo "installing fav fonts..."
cp ../fonts/*.ttf /Library/Fonts/
echo "installing Chromium..."
brew install Caskroom/cask/chromium
echo "installing unetbootin..."
brew install Caskroom/cask/unetbootin
echo "installing all pip packages..."
sudo pip3 install -R ../requirements.txt
echo "running osx lockdown checks..."
mkdir $HOME/projects
cd $HOME/projects
git clone git@github.com:kristovatlas/osx-config-check.git osxlockdown
cd osxlockdown
python app.py
dialog --clear \
                --title "ALL FINISHED, ENJOY YOUR NEW DESKTOP & HAPPY CREATING" \
                --menu "$MENU" \
                $HEIGHT $WIDTH
