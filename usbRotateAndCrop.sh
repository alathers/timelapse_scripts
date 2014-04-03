#!/bin/bash


#  I'm gonna have to pre-bucket the images into sets based on when they were take, and where the camera was adjusted to.  The belo
#      example is seamingly more accurate for the earlier images.  Items taken in March don't seem to have the same borders
for h in $(ls -1 *jpg); do 
	file=`basename $h .jpg`
	if [ ! -s rotated/${file}.jpg ]; then 
		convert -rotate -6 ${file}.jpg rotated/${file}.jpg
		convert -crop 1750x900+95+195 rotated/${file}.jpg cropped/${file}.jpg
	fi
done
