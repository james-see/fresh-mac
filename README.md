# Fresh Mac

Fresh as in Fresh!
_a collection of setup scripts &amp; default app installer for a fresh Mac OS install complete with a full & core version_

![](https://i.imgur.com/5cNy1F7.png)

## HOW TO RUN

Simply run `git clone https://github.com/jamesacampbell/fresh-mac.git` and then `cd fresh-mac` and then `python installer.py [your contact email or phone number]` and you are done. Once it is complete you can `cp configs/zshrc ~/.zshrc` and then `source ~/.zshrc` to get my exact zsh config and theme working. Passing in the phone number or email is important to ensure the message on the login screen of your mac has your contact info in case the computer goes missing.

## INCLUDED CORE (lite setup)

### Basic stuff
- [HOMEBREW](https://brew.sh)
- [TUNNELBLICK](https://www.tunnelblick.net/)
- [CHROMIUM](https://www.chromium.org/)
- [CALIBRE](https://caibre-ebook.com/)
- [ZSH](https://www.zsh.org/) & [OH-MY-ZSH](http://ohmyz.sh/)
- [GPG TOOLS](https://gpgtools.org/)
- [TOR](https://www.torproject.org/download/download.html.en) (brew services start tor, config in /usr/local/etc/tor/, running at 127.0.0.1:9050)
- [PRIVOXY](http://www.privoxy.org/) (brew services start privoxy, config in /usr/local/etc/privoxy/, running at 127.0.0.1:8118)
- [PYTHON 3 & PIP](https://www.python.org/)
- lots of python libraries via requirements.txt
### Security Stuff  
- DNSCRYPT for secure DNS lookups & works with Privoxy
- WIPE profile image to default
- SET MESSAGE ON login to call if found for reward
- LOCK DOWN FIREWALL (turn on stealth mode, etc.)
- TURN ON FULL DISK ENCRYPTION
- DUMP FULL DISK ENCRYPTION KEY OUT OF MEMORY ON SLEEP
- Turn off auto-allowing signed apps from pooping/popping through firewall
- Enforces hibernation
- Turn off powernap BS (no, don't ping the internet assholes when my computer is asleep)
- SET default browser to Chromium
### Other Niceties in Core  
- [NERD-FONTS](https://github.com/ryanoasis/nerd-fonts)
- BAT for cat (aliased)
- EXA for ls (aliased)
- JQ for pretty print json and sanity & sweet pipe moves
- TREE for pretty dirs and files list views for days
- GOLANG - because it is better than Python in every way and not as difficult as Rust
- RVM to manage ruby versions
- [mdcat](https://github.com/lunaryorn/mdcat) render markdown
- parquet-tools to view parquet files and other BS like that

## INCLUDED BATTERIES INCLUDED

ALL OF CORE PLUS:

- [TASKWARRIOR](https://taskwarrior.org/)
- [IMAGEMAGICK](https://www.imagemagick.org/script/index.php)
- [BALENA ETCHER](https://www.balena.io/etcher/)
- [BARTENDER](https://www.macbartender.com) requires license but worth it IMO
- [CODA](https://www.panic.com/coda/)
- [PHP-FPM](https://php-fpm.org/download/)
- [NGINX](https://nginx.org/en/download.html)
- [MYSQL](https://dev.mysql.com/downloads/)
- [NODE](https://nodejs.org/en/download/) / [NPM](https://www.npmjs.com/package/download)
- [HTOP](http://hisham.hm/htop/)
- [TMUX](https://github.com/tmux/tmux/wiki)
- [CHARLES](https://www.charlesproxy.com/) requires one time license
- [LITTLE SNITCH](https://www.obdev.at/products/littlesnitch/index.html) requires one time license
- [HASKELL](https://www.haskell.org/)
- [ELIXIR](https://elixir-lang.org/)
- [ELM](https://elm-lang.org/)
- [VIRTUALBOX](https://www.virtualbox.org/)
- [DOCKER](https://docs.docker.com/install/)
- [SPECTACLE](https://www.spectacleapp.com/)
- [VAGRANT](https://www.vagrantup.com/) and VAGRANT-MANAGER
- [RUST](https://www.rust-lang.org/)
- [DUST](https://github.com/bootandy/dust)
- [PIANOBAR](https://github.com/PromyLOPh/pianobar/)
- [BLUETILITY](https://github.com/jnross/Bluetility)
- [SLACK-TERM](https://github.com/erroneousboat/slack-term) slack terminal client
- [RAINBOWSTREAM](https://github.com/orakaro/rainbowstream) twitter terminal client
- [PROXYCHAINS](https://github.com/rofl0r/proxychains-ng) run by `proxychains4` and your command to proxy via Tor or any other web/socks proxy before you hit your destination
- [PURE prompt](https://github.com/sindresorhus/pure) a great prompt for zsh
- [SPOTIFY-TUI](https://github.com/Rigellute/spotify-tui) spotify terminal client written in Rust
- [SPOTIFYD](https://github.com/Spotifyd/spotifyd) spotify service that you connect spotify-tui to

## HOW TO CONTRIBUTE

Fork it and issue a pull request!

## FUTURE PLANS

Adding an ansible version instead of pure BASH.

## Update Log

27JUN2022 Added wipe the Dock of crapware, updated pip permissions, fixed some other M1 related stuff

14NOV2021: Added slack-term and rainbowstream
