#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

if [ -f $NAMESFILE ]; then

	. $NAMESFILE

else
	echo "Error: Names file does not exist."
	exit $?

fi

DATA_BASE="notifications"
COLLECTIONS=(
    "subscription" "notification" "transmission")
DUMP_FILES=(
    $SUPPORTNOTIFICATION_SUBSCRIPTION_DATADUMP
    $SUPPORTNOTIFICATION_NOTIFICATION_DATADUMP
    $SUPPORTNOTIFICATION_TRANSMISSION_DATADUMP
)

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
