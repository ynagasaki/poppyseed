#!/bin/bash
debug=0

if [ $# != 0 ]; then
	for arg in $@; do
		if [ arg = "debug" ]; then
			debug=1
		fi
	done
fi

echo Running lint...
python hxlint.py

echo
echo Building and running...
echo "debug=$debug"
if [ debug == 1 ]; then
	lime -debug test neko
else
	lime test neko
fi
