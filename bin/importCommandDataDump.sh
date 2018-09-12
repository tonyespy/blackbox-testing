#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

DATA_BASE="metadata"
COLLECTIONS=( "addressable" "device" "deviceProfile" "deviceService" "command" )
DUMP_FILES=( $ADDRESSABLECCDATADUMP $DEVICECCDATADUMP $DEVICEPROFILECCDATADUMP $DEVICESERVICECCDATADUMP $COMMANDCCDATADUMP )

if [ "$SNAPTEST" == "true" ] ; then
    COMMAND="edgexfoundry.mongoimport"
else
    COMMAND="docker-compose exec -T mongo /bin/bash -c mongoimport"
fi

for index in "${!DUMP_FILES[@]}"
do
    ${COMMAND} -d ${DATA_BASE} -c ${COLLECTIONS[index]} --file ${DUMP_FILES[index]}

    echo "Info: ${DUMP_FILES[index]} data imported"
done
