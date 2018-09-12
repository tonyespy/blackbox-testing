#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh
CONFIGDUMPJS=/etc/newman/javascript/exportclient/exportConfiguration.js

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

if [ "$SNAPTEST" == "true" ] ; then
    CONFIGDUMPJS=postman-test/javascript/exportclient/exportConfiguration.js

    COMMAND="edgexfoundry.mongo"
else
    CONFIGDUMPJS=/etc/newman/javascript/exportclient/exportConfiguration.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi

DATA_BASE="exportclient"
FLUSH_SCRIPTS=( $CONFIGDUMPJS )

for index in "${!FLUSH_SCRIPTS[@]}"
do

    ${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPTS[index]}

    echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

done
