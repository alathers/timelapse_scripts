#!/bin/bash


# Just a basic "take a good photo" and name it something sane
project='hawaii'
timestamp=`date +%Y%m%d-%H-%M-%S`
## In case the camera isn't "pointing up"
rotation='--rotation 180'
image_path="/home/pi/images"

[ -d ${image_path} ] || mkdir -p ${image_path}

/usr/bin/raspistill -q 100 -ex auto -awb auto ${rotation} -o ${image_path}/${project}-${timestamp}.jpg
