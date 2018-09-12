#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

_TESTMODE=${_TESTMODE:docker}

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

echo "Info: Initiating Logging Test."

if [ "$_TESTMODE" == "docker" ] ; then

    COLLECTION_PATH="collections/support-logging.postman_collection.json"
    ENV_PATH="environment/support-logging-docker.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="logs" --iteration-data="data/loggingData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="logs_error_4xx" --iteration-data="data/loggingData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="ping" --iteration-data="data/loggingData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    COLLECTION_PATH="./postman-test/collections/support-logging.postman_collection.json"
    ENV_PATH="./postman-test/environment/support-logging.postman_environment.json"

    echo "[info] ---------- use newman ----------"

    newman run ${COLLECTION_PATH} \
	   --folder logging -e ${ENV_PATH} \
	   -d ./postman-test/data/loggingData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder logging_error_4xx -e ${ENV_PATH} \
	   -d ./postman-test/data/loggingData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder ping -e ${ENV_PATH} \
	   -d ./postman-test/data/loggingData.json \
	   -r cli
	   #
	   # newman: "html" reporter could not be loaded.
	   # run `npm install newman-reporter-html`
	   # -r cli,html
fi

echo "Info:Command Test Completed."
