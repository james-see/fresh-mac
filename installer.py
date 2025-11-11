"""Fresh Mac installer for zsh configuration and setup scripts."""
# Author: James Campbell
# What: Runs the run.sh installer script and copies the zsh file into place
import subprocess
import sys
import os
from pathlib import Path

os.environ['PHONE'] = str(sys.argv[1]) if len(sys.argv) > 1 else ""

print("Running main installation script...")
subprocess.run(["./run.sh"], check=True)

print("\nSetting up custom zsh configuration...")
home = Path.home()
zshrc_path = home / ".zshrc"
backup_path = home / ".zshrc-backup"

# Backup existing .zshrc if it exists
if zshrc_path.exists():
    print(f"Backing up existing .zshrc to {backup_path}")
    subprocess.run(["mv", str(zshrc_path), str(backup_path)], check=False)

# Copy custom zshrc
print("Copying custom zshrc configuration...")
subprocess.run(["cp", "./configs/zshrc", str(zshrc_path)], check=True)

# Change default shell to zsh
print("\nChanging default shell to zsh...")
zsh_path = subprocess.run(["which", "zsh"], capture_output=True, text=True).stdout.strip()
subprocess.run(["chsh", "-s", zsh_path], check=True)

print("\n✓ Installation complete!")
print("Please restart your terminal or run: exec zsh")
sys.exit(0)
