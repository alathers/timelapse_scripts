#!/bin/bash

for h in $(ls -1 *jpg); do 
	file=`basename $h .jpg`
	convert -rotate -6 ${file}.jpg rotated/${file}.jpg
	convert -crop 1750x900+95+195 rotated/${file}.jpg cropped/${file}.jpg
done
