#!/bin/bash

. ./config


# Check github for updates
git remote update
git status -uno | egrep 'Your branch is behind'
behind=$?
if [ ${behind} -eq 0 ]; then
	echo "changes made, pulling update"
	git pull
else
	echo "no updates"
	exit
fi


#  Pull down updates


# Replace scripts with updates


# Reload crontab if needed; or even just reboot?

###  Probably only do the de-template pass if there's a change?
cat crontab.template | sed "s/CRON_TIME_STRING/${cron_time_string}/" | \
	sed "s|RSYNC_PATH|${rsync_path}|" | \
	sed "s|LOCAL_PATH|${local_filepath}|" | \
	sed "s/REMOTE_USER/${remoteuser}/" | \
	sed "s/REMOTE_HOST/${remotehost}/" >  tempfile #  ${SENDER_CRONFILE_PATH}
	rm tempfile


# Checksums of files

## Disk info?

## Check in new info