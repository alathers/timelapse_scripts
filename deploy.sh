#!/bin/bash

timelapse_src='/home/pi/src/timelapse_scripts'

pushd ${timelapse_src}

. ./config


function detemplate_copy_cron {
	cat copy_crontab.template | sed "s/CRON_TIME_STRING/${copy_cron_time_string}/" | \
		sed "s|RSYNC_PATH|${rsync_path}|" | \
		sed "s|LOCAL_PATH|${local_filepath}|" | \
		sed "s/REMOTE_USER/${remoteuser}/" | \
		sed "s/REMOTE_HOST/${remotehost}/" >  timelapse-copycron 

}


function detemplate_snapshot_cron {
	snapshot_script="${timelapse_src}/snapshot.sh"
	cat snapshot_crontab.template | sed "s/CRON_TIME_STRING/${snapshot_cron_time_string}/" | \
		sed "s|SNAPSHOT_SCRIPT_PATH|${snapshot_script}|" >  timelapse-snapshotcron 
}

function detemplate_deploy_cron {
	deploy_script="${timelapse_src}/deploy.sh"
	cat deploy_crontab.template | sed "s/CRON_TIME_STRING/${snapshot_cron_time_string}/" | \
		sed "s|DEPLOY_SCRIPT_PATH|${deploy_script}|" > timelapse-deploycron 
}


function deploy_cronfiles {
	sudo mv timelapse-copycron ${SENDER_CRONFILE_PATH}
	sudo mv timelapse-snapshotcron ${SENDER_CRONFILE_PATH}
	sudo mv timelapse-deploycron ${DEPLOY_CRONFILE_PATH}
	sudo chown 0755 /etc/cron.d/*
}

function generate_report {

	${md5deep} -r ${timelapse_src}/* > remote_filesums
	echo "---" >> remote_filesums
	find images -type f | wc -l >> remote_filesums
	df -hl >> remote_filesums
}


# Check github for updates
git remote update
git status -uno | egrep 'Your branch is behind'
behind=$?
if [ ${behind} -eq 0 ]; then
	echo "changes made, pulling update"
	git pull
	# checksum the outputs!
	detemplate_copy_cron
	detemplate_snapshot_cron
	detemplate_deploy_cron
	generate_report
	deploy_cronfiles
	# remove them then push the sums!
	git add remote_filesums
	git commit -m "Checksums from $(hostname) on $(date)"
	git push

else
	echo "no updates"
fi

exit


#  Pull down updates

# Replace scripts with updates


# Reload crontab if needed; or even just reboot?

###  Probably only do the de-template pass if there's a change?



# Checksums of files

## Disk info?

## Check in new info