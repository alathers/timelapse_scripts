#!/bin/bash


### This should be set up to run for some interval <  daily so that it can run for a while and then end and restart


#webpath="/usr/share/nginx/html"
webpath="/var/www/html"
#@@webpath="/home/pi/images/"

#path=$1
path='/home/pi/images/'
#shift
timestamp=`date +%Y%m%d-%H-%M-%S`
#/usr/bin/raspistill -q 100 -ex auto -awb auto $* -l ${webpath}/picam-full.jpg -o ${path}/${timestamp}.jpg
#/usr/bin/convert -resize 33% ${webpath}/picam-full.jpg ${webpath}/picam.jpg


project='hawaii'
# seconds
timelapse_frequency=
timelapse_miliseconds=$((${timelapse_frequency}*1000))

## In case the camera isn't "pointing up"
rotation='--rotation 180'


#/usr/bin/raspistill -q 100 -ex auto -awb auto --rotation 180 -t 200000000 -tl 30000 -o /home/pi/images/hawaii-${timestamp}-%010d.jpg -l ${webpath}/last.jpg
/usr/bin/raspistill -q 100 -ex auto -awb auto ${rotation} -t 0 -tl ${timelapse_miliseconds} \
	-o /home/pi/images/${project}-${timestamp}-%010d.jpg -l ${webpath}/last.jpg
