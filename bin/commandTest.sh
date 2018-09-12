#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh


_TESTMODE=${_TESTMODE:docker}

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

echo "Info: Initiating Command Test."

if [ "$_TESTMODE" == "docker" ] ; then

    COLLECTION_PATH="collections/core-command.postman_collection.json"
    ENV_PATH="environment/command.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="device" --iteration-data="data/coreCommandData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="device_error_4xx" --iteration-data="data/coreCommandData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    COLLECTION_PATH="./postman-test/collections/core-command.postman_collection.json"
    ENV_PATH="./postman-test/environment/command.postman_environment.json"

    echo "[info] ---------- use newman ----------"

    newman run ${COLLECTION_PATH} \
	   --folder device -e ${ENV_PATH} \
	   -d ./postman-test/data/coreCommandData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder device_error_4xx -e ${ENV_PATH} \
	   -d ./postman-test/data/coreCommandData.json \
	   -r cli
fi

#docker run --rm -v ~/${TEST_DIR}/postman-test/:/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run "${COLLECTION_PATH}" \
#    --folder="device" --iteration-data="data/coreCommandData.json" --environment="${ENV_PATH}" \
#    --reporters="junit,cli"
#docker run --rm -v ~/${TEST_DIR}/postman-test/:/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run "${COLLECTION_PATH}" \
#    --folder="device_error_4xx" --iteration-data="data/coreCommandData.json" --environment="${ENV_PATH}" \
#    --reporters="junit,cli"


#newman run $CORECOMMANDCOLLFILE --folder device -d $CORECOMMANDDATAFILE -e $CORECOMMANDENVFILE -r cli,html --reporter-html-export $DEVICECCREPORT200FILE
#
#newman run $CORECOMMANDCOLLFILE --folder device_error_4xx -d $CORECOMMANDDATAFILE -e $CORECOMMANDENVFILE -r cli,html --reporter-html-export $DEVICECCREPORT4XXFILE

echo "Info:Command Test Completed."
