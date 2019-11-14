#!/usr/bin/python
# Author: James Campbell
# What: Runs the run.sh installer script and copies the zsh file into place
import sys
from subprocess import call
call(["./run.sh"])
call(["mv", "$HOME/.zshrc", "$HOME/.zshrc-backup"])
call(["cp", "./configs/zshrc", "$HOME/.zshrc"])
print("setting up the new zshrc")
call(["exec", "zsh"])
exit("finis")
