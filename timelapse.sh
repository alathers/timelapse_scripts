#!/bin/bash


webpath="/usr/share/nginx/www"
path=$1
shift
timestamp=`date +%Y%m%d-%H-%M-%S`
/usr/bin/raspistill -q 100 -ex auto -awb auto $* -l ${webpath}/picam-full.jpg -o ${path}/${timestamp}.jpg
/usr/bin/convert -resize 33% ${webpath}/picam-full.jpg ${webpath}/picam.jpg