#!/bin/bash
debug=false

if [ $# != 0 ]; then
	for arg in $@; do
		if [ arg = "debug" ]; then
			debug=true
		fi
	done
fi

echo Running lint...
python hxlint.py

echo
echo Building and running...
if [ debug ]; then
	lime -debug test neko
else
	lime test neko
fi
