#!/usr/bin/python

import os, re
import os.path

RE_VARIABLE = re.compile(r'\w*\s*var\s+(?P<var_name>[a-zA-Z_][a-zA-Z0-9_]*)\s*:[^;]*;')

def unused_imports(lines):
	imported = [];
	for line in lines:
		line = line.strip()
		if len(line) == 0:
			continue
		elif "import" in line:
			imported.append(line.strip(";").strip().split(".")[-1])
		else:
			line_words = re.split(r'\W+', line)
			for line_word in line_words:
				if line_word in imported:
					imported.remove(line_word)
	return imported

def unused_variables(lines):
	variables = [];
	for line in lines:
		line = line.strip()
		if "public" in line:
			continue
		match = RE_VARIABLE.search(line);
		if match == None:
			continue
		variables.append(match.group("var_name"))
	for line in lines:
		if len(line) == 0 or "var" in line:
			continue
		else:
			line_words = re.split(r'\W+', line)
			for line_word in line_words:
				if line_word in variables:
					variables.remove(line_word)
				if len(variables) == 0:
					return variables
	return variables

for dirpath, dirnames, filenames in os.walk("./source/"):
	for filename in [f for f in filenames if f.endswith(".hx")]:
		fname = os.path.join(dirpath, filename)
		print "checking", fname
		fin = open(fname, "r")
		lines = fin.readlines()
		fin.close()
		for item in unused_imports(lines):
			print " ~ unused import  :", item
		for item in unused_variables(lines):
			print " ~ unused variable:", item
