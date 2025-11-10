"""Fresh Mac installer for zsh configuration and setup scripts."""
# Author: James Campbell
# What: Runs the run.sh installer script and copies the zsh file into place
import subprocess
import sys
import os

os.environ['PHONE'] = str(sys.argv[1]) if len(sys.argv) > 1 else ""
subprocess.run(["./run.sh"], check=True)
subprocess.run(["mv", "$HOME/.zshrc", "$HOME/.zshrc-backup"], check=False)
subprocess.run(["cp", "./configs/zshrc", "$HOME/.zshrc"], check=True)
print("Setting up the new zshrc")
subprocess.run(["exec", "zsh"])
sys.exit("finis")
