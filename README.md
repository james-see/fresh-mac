# Fresh Mac

Fresh as in Fresh!
_a collection of setup scripts &amp; default app installer for a fresh Mac OS install complete with a full & core version_

![](https://i.imgur.com/5cNy1F7.png)

## HOW TO RUN

Simply run `git clone https://github.com/jamesacampbell/fresh-mac.git` and then `cd fresh-mac` and then `python installer.py [your contact email or phone number]` and you are done. Once it is complete you can `cp configs/zshrc ~/.zshrc` and then `source ~/.zshrc` to get my exact zsh config and theme working. Passing in the phone number or email is important to ensure the message on the login screen of your mac has your contact info in case the computer goes missing.

## INCLUDED CORE (lite setup)

### Basic stuff
- [HOMEBREW](https://brew.sh)
- [UV](https://github.com/astral-sh/uv) - Fast Python package installer and resolver
- [ORBSTACK](https://orbstack.dev/) - Modern Docker Desktop alternative with faster containers and Linux VMs
- [CADDY](https://caddyserver.com/) - Modern web server with automatic HTTPS
- [TUNNELBLICK](https://www.tunnelblick.net/)
- [CHROMIUM](https://www.chromium.org/)
- [CALIBRE](https://caibre-ebook.com/)
- [ZSH](https://www.zsh.org/) & [OH-MY-ZSH](http://ohmyz.sh/)
- [PYTHON 3](https://www.python.org/)
- Python CLI tools and libraries managed via uv
### Security Stuff  
- DNSCRYPT for secure DNS lookups
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

### Python Package Management

We use `uv` for fast, modern Python package management:
- **CLI tools** (bpython, httpie, grip, etc.) installed via `uv tool install` - isolated environments like pipx, globally accessible
- **Libraries** (pandas, flask, requests, etc.) installed via `uv pip install` - faster pip replacement
- Benefits: Clean separation, no dependency conflicts between tools, 10-100x faster than pip

## INCLUDED BATTERIES INCLUDED

ALL OF CORE PLUS:

- [TOR](https://www.torproject.org/download/download.html.en) (brew services start tor, config in /usr/local/etc/tor/, running at 127.0.0.1:9050)
- [PRIVOXY](http://www.privoxy.org/) (brew services start privoxy, config in /usr/local/etc/privoxy/, running at 127.0.0.1:8118)
- **OPTIONAL ENHANCED PRIVACY SETTINGS** - Prompted at end of installation
  - Disables analytics & crash reporting to Apple
  - Disables Siri & Spotlight suggestions
  - Disables Handoff & Continuity features
  - Blocks Safari cookies & enables Do Not Track
  - Disables location services
  - Disables Bonjour advertising
  - Enables advanced fingerprinting protection
  - Disables clipboard history in Spotlight
  - Clears saved Wi-Fi networks
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

## TESTING

To test the installation in a VM before running on your main machine:

### Quick Start Testing
```bash
# Run the test helper
./test-vm.sh
```

### Testing Options

1. **UTM (Apple Silicon Macs)** - Best for full macOS testing
   - Install: `brew install --cask utm`
   - Create VM with 8GB+ RAM, 60GB+ disk
   - Install fresh macOS

2. **Tart (Automated macOS VMs)** - Best for CI/CD
   - Install: `brew install cirruslabs/cli/tart`
   - Run: `./test-vm.sh` and choose option 2

3. **OrbStack (Linux VMs)** - Best for quick script logic testing
   - Install: `brew install --cask orbstack`
   - Tests bash logic, not macOS-specific commands

### Validation After Installation

Run the validation script in your VM after installation:
```bash
./validate-install.sh
```

This checks:
- All core tools installed (brew, uv, caddy, orbstack, etc.)
- Security settings applied (firewall, FileVault, stealth mode)
- Services running (dnscrypt-proxy, tor, privoxy if applicable)
- Privacy settings (if enhanced privacy was enabled)
- UI changes (dock cleared, login message set)

## HOW TO CONTRIBUTE

Fork it and issue a pull request!

## FUTURE PLANS

Adding an ansible version instead of pure BASH.

## Update Log

10NOV2025: Major modernization update
- Added UV for fast Python package management (10-100x faster than pip)
- Split Python packages into CLI tools (uv tool install) and libraries (uv pip install)
- Added OrbStack as modern Docker Desktop alternative to core
- Added Caddy web server with automatic HTTPS to core
- Modernized installer.py to use subprocess.run() instead of deprecated call()
- Removed legacy GPG Tools from core
- Moved TOR and Privoxy to batteries included section (privacy-focused users)
- Added optional enhanced privacy settings for batteries included users
  - 12 privacy-hardening commands compatible with macOS Tahoe
  - Disables analytics, Siri, location services, Handoff, etc.
  - User prompted at end of installation to opt-in
- Verified all commands work in macOS Tahoe (final Intel Mac version)
- Updated documentation with new Python package management approach

27JUN2022: Added wipe the Dock of crapware, updated pip permissions, fixed some other M1 related stuff

14NOV2021: Added slack-term and rainbowstream
