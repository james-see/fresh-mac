#!/usr/bin/python
# Author: James Campbell
# What: Runs the run.sh installer script
import sys
from subprocess import call
call(["chmod", "a+x", "first-run/run.sh"])
call(["cd first-run && ./run.sh"])
exit("finis")
