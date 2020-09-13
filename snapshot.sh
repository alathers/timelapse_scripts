#!/bin/bash


# Just a basic "take a good photo" and name it something sane
project='test'
timestamp=`date +%Y%m%d-%H-%M-%S`
## In case the camera isn't "pointing up"
rotation='--rotation 180'
image_path="/home/pi/"


/usr/bin/raspistill -q 100 -ex auto -awb auto ${rotation} -o ${image_path}/${project}-${timestamp}.jpg
