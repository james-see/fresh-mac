#!/usr/bin/python
# Author: James Campbell
# What: Runs the run.sh installer script and copies the zsh file into place
import sys
from subprocess import call
call(["chmod", "a+x", "run.sh"])
call(["./run.sh"])
mv $HOME/.zshrc $HOME/.zshrc-backup
cp. / configs / zshrc $ HOME / .zshrc
print("setting up the new zshrc")
call(["exec", "zsh"])
exit("finis")
