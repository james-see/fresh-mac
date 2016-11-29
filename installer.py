#!/usr/bin/python
# Author: James Campbell
# What: Runs the run.sh installer script
import sys
from subprocess import call
call(["chmod", "a+x", "run.sh"])
call(["./run.sh"])
exit("finis")
