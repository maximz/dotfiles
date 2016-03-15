#!/usr/bin/python
import sys
import ntpath

if len(sys.argv) > 1:
	pathin = sys.argv[1]
else:
	pathin = sys.stdin.read()

if len(pathin) == 0:
	sys.exit(0)

def path_leaf(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
sys.stdout.write(path_leaf(pathin))