#!/bin/bash

timelapse_src='/home/pi/src/timelapse_scripts'
deploy_script="${timelapse_src}/deploy.sh"

pushd ${timelapse_src}

. ./config.generic

. ./config

# command line arg to force a deploy
deploy_force=${1:-0}

function detemplate_copy_cron {
	sed "s|CRON_TIME_STRING|${copy_cron_time_string}|" copy_crontab.template | \
		sed "s|RSYNC_PATH|${rsync_path}|" | \
		sed "s|LOCAL_PATH|${local_filepath}|" | \
		sed "s|REMOTE_USER|${remoteuser}|" | \
		sed "s|CRON_KILL_TIME_STRING|${kill_copy_time_string}|" | \
		sed "s|PKILL|${pkill}|" | \
		sed "s|PORT|${remoteport}|" | \
		sed "s|LOG_PATH|${timelapse_src}|g" | \
		sed "s|REMOTE_HOST|${remotehost}|" >  timelapse-copycron 

}


function detemplate_snapshot_cron {
	snapshot_script="${timelapse_src}/snapshot.sh"
	sed "s|CRON_TIME_STRING|${snapshot_cron_time_string}|" snapshot_crontab.template | \
		sed "s|LOG_PATH|${timelapse_src}|g" | \
		sed "s|SNAPSHOT_SCRIPT_PATH|${snapshot_script}|" >  timelapse-snapshotcron 
}

function detemplate_deploy_cron {
	sed "s|CRON_TIME_STRING|${deploy_cron_time_string}|" deploy_cron.template | \
		sed "s|LOG_PATH|${timelapse_src}|g" | \
		sed "s|DEPLOY_SCRIPT_PATH|${deploy_script}|" > timelapse-deploycron 
}


function detemplate_runlog_cron {
	checkin_script="${timelapse_src}/checkin.sh"
	sed "s|CRON_TIME_STRING|${run_cron_time_string}|" runlog_update_cron.template | \
		sed "s|LOG_PATH|${timelapse_src}|g" | \
		sed "s|CHECKIN_SCRIPT_PATH|${checkin_script}|" > timelapse-checkincron 
}


function deploy_cronfiles {
	sudo mv timelapse-copycron ${SENDER_CRONFILE_PATH}
	sudo mv timelapse-snapshotcron ${SNAPSHOT_CRONFILE_PATH}
	sudo mv timelapse-deploycron ${DEPLOY_CRONFILE_PATH}
	sudo mv timelapse-checkincron ${CHECKIN_CRONFILE_PATH}

	sudo chmod 0755 /etc/cron.d/*
	sudo chown root:root /etc/cron.d/*
}

function generate_report {
	echo $(date) > remote_filesums

	${md5deep} -r ${timelapse_src}/* >> remote_filesums
	echo "---" >> remote_filesums
	find ${local_filepath} -type f | wc -l >> remote_filesums
	df -hl >> remote_filesums
}


# Check github for updates
git remote update
git status -uno | egrep 'Your branch is behind'
behind=$?
if [ ${behind} -eq 0 ] || [ ${deploy_force} -eq 1 ]; then
	echo "changes made, pulling update"
	git pull
	# checksum the outputs!
	detemplate_copy_cron
	detemplate_snapshot_cron
	detemplate_deploy_cron
	detemplate_runlog_cron

	generate_report
	deploy_cronfiles
	# remove them then push the sums!
	git add remote_filesums runlog
	git commit -m "Checksums from $(hostname) on $(date)"
	git push
	[ ${deploy_script} ] || ${deploy_script} 1
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