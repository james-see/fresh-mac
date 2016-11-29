#!/bin/bash
echo "installing xcode tools..."
xcode-select --install
echo "installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "installing git..."
brew install git
echo "installing cask..."
brew tap caskroom/cask
echo "installing iterm2..."
brew install Caskroom/cask/iterm2
echo "installing gpgtools..."
brew install Caskroom/cask/gpgtools
echo "installing zsh..."
brew install zsh --upgrade
echo "installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ../assets/zshrc ~/.zshrc
