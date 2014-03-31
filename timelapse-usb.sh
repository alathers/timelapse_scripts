#!/bin/bash

webpath="/usr/share/nginx/www"
cam=`ls -1 /dev/video*`
path=$1
shift
timestamp=`date +%Y%m%d-%H-%M-%S`
/usr/bin/fswebcam -q -d $cam -r 1920x1080 -D 3 --no-banner $* -S 5 ${path}/${timestamp}.jpg
rm ${webpath}/usbcam.jpg
ln -s ${path}/${timestamp}.jpg  ${webpath}/usbcam.jpg