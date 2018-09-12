#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

if [ "$SNAPTEST" == "true" ] ; then
    EVENTDUMPJS=postman-test/javascript/coredata/event.js
    READINGDUMPJS=postman-test/javascript/coredata/reading.js
    VDDUMPJS=postman-test/javascript/coredata/valueDescriptor.js

    COMMAND="edgexfoundry.mongo"
else
    EVENTDUMPJS=/etc/newman/javascript/coredata/event.js
    READINGDUMPJS=/etc/newman/javascript/coredata/reading.js
    VDDUMPJS=/etc/newman/javascript/coredata/valueDescriptor.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi

DATA_BASE="coredata"
FLUSH_SCRIPTS=( $EVENTDUMPJS $READINGDUMPJS $VDDUMPJS)

echo "flush Core Data Dump - $FLUSH_SCRIPTS"

for index in "${!FLUSH_SCRIPTS[@]}"
do
    echo "flush Core Data Dump - $index"

    ${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPTS[index]}

    # This is always output, even if the above fails!
    echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

done
