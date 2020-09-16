#!/bin/bash

# not in the configs because the script needs it to find them and I'm too lazy to do the "run from" logic
timelapse_src='/home/pi/src/timelapse_scripts'
pushd ${timelapse_src}

. ./config.generic

. ./config

echo "------ " >> runlog
echo "" >> runlog
echo "" >> runlog
sudo /bin/egrep ERROR /var/log/syslog >> runlog
echo "" >> runlog
echo "" >> runlog
echo "------ " >> runlog




git pull
git add runlog
git commit -m "Updating Runlog"
git push