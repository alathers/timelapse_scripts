#!/bin/bash
#
#  Adam Lathers
# alathers@gmail.com
#


# Concatinate all mp4 files in the dir
## Maybe do something fancy with the future output name, like state-date-thru_today or something?


/Applications/ffmpegX_0.0.9y/bin/mencoder -oac copy -ovc copy -idx -o output.mp4 *.mp4


# Tag with meta data and such
