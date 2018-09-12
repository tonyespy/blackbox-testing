#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

if [ "$SNAPTEST" == "true" ] ; then
    ADDRESSABLE_JS=postman-test/javascript/metadata/addressable.js
    DEVICE_JS=postman-test/javascript/metadata/device.js
    COMMAND_JS=postman-test/javascript/metadata/command.js
    DEVICEMANAGER_JS=postman-test/javascript/metadata/deviceManager.js
    DEVICPROFILE_JS=postman-test/javascript/metadata/deviceProfile.js
    DEVICEREPORT_JS=postman-test/javascript/metadata/deviceReport.js
    DEVICESERVICE_JS=postman-test/javascript/metadata/deviceService.js
    PROVISIONWATCHER_JS=postman-test/javascript/metadata/provisionWatcher.js
    SCHEDULE_JS=postman-test/javascript/metadata/schedule.js
    SCHEDULEEVENT_JS=postman-test/javascript/metadata/scheduleEvent.js

    COMMAND="edgexfoundry.mongo"
else
    ADDRESSABLE_JS=/etc/newman/javascript/metadata/addressable.js
    DEVICE_JS=/etc/newman/javascript/metadata/device.js
    COMMAND_JS=/etc/newman/javascript/metadata/command.js
    DEVICEMANAGER_JS=/etc/newman/javascript/metadata/deviceManager.js
    DEVICPROFILE_JS=/etc/newman/javascript/metadata/deviceProfile.js
    DEVICEREPORT_JS=/etc/newman/javascript/metadata/deviceReport.js
    DEVICESERVICE_JS=/etc/newman/javascript/metadata/deviceService.js
    PROVISIONWATCHER_JS=/etc/newman/javascript/metadata/provisionWatcher.js
    SCHEDULE_JS=/etc/newman/javascript/metadata/schedule.js
    SCHEDULEEVENT_JS=/etc/newman/javascript/metadata/scheduleEvent.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi

DATA_BASE="metadata"
FLUSH_SCRIPTS=( $ADDRESSABLE_JS $DEVICE_JS $DEVICEREPORT_JS $DEVICPROFILE_JS $DEVICESERVICE_JS $PROVISIONWATCHER_JS $SCHEDULE_JS $SCHEDULEEVENT_JS $COMMAND_JS )

for index in "${!FLUSH_SCRIPTS[@]}"
do
    ${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPTS[index]}

    echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

done
