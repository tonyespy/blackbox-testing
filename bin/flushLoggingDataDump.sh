#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh
LOGGINGDUMPJS=/etc/newman/javascript/logging/logEntry.js

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

if [ "$SNAPTEST" == "true" ] ; then
    LOGGINGDUMPJS=postman-test/javascript/logging/logEntry.js

    COMMAND="edgexfoundry.mongo"
else
    LOGGINGDUMPJS=/etc/newman/javascript/logging/logEntry.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi

DATA_BASE="logging"
FLUSH_SCRIPTS=( $LOGGINGDUMPJS )

for index in "${!FLUSH_SCRIPTS[@]}"
do
    ${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPTS[index]}

    echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

done
