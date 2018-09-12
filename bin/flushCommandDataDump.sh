#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

# NOTE - this logic could be cleaned up by making _TESTMODE
# a global (maybe in files.sh), and then using variables to
# update the paths. This is a little tricky getting the
# quoting correct due to the way the command-line passed to
# docker-compose is constructed, hence the brute force approach.

if [ "$SNAPTEST" == "true" ] ; then
    ADDRESSABLE_JS=postman-test/javascript/command/addressable.js
    DEVICE_JS=postman-test/javascript/command/device.js
    COMMAND_JS=postman-test/javascript/command/command.js
    DEVICPROFILE_JS=postman-test/javascript/command/deviceProfile.js
    DEVICESERVICE_JS=postman-test/javascript/command/deviceService.js

    COMMAND="edgexfoundry.mongo"
else
    ADDRESSABLE_JS=/etc/newman/javascript/command/addressable.js
    DEVICE_JS=/etc/newman/javascript/command/device.js
    COMMAND_JS=/etc/newman/javascript/command/command.js
    DEVICPROFILE_JS=/etc/newman/javascript/command/deviceProfile.js
    DEVICESERVICE_JS=/etc/newman/javascript/command/deviceService.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi


DATA_BASE="metadata"
FLUSH_SCRIPTS=( $ADDRESSABLE_JS $DEVICE_JS $DEVICPROFILE_JS $DEVICESERVICE_JS $COMMAND_JS )

for index in "${!FLUSH_SCRIPTS[@]}"
do
    ${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPTS[index]}

    echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

done
