#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

_TESTMODE=${_TESTMODE:docker}

if [ -f $NAMESFILE ]; then

	. $NAMESFILE

else
	echo "Error: Names file does not exist."
	exit $?

fi

echo "Info: Initiating Rulesengine Test."

if [ "$_TESTMODE" == "docker" ] ; then
    COLLECTION_PATH="collections/support-rulesengine.postman_collection.json"
    ENV_PATH="environment/support-rulesengine-docker.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="rules" --iteration-data="data/rulesengineData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="rules_error_5xx" --iteration-data="data/rulesengineData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="ping" --iteration-data="data/rulesengineData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    COLLECTION_PATH="./postman-test/collections/support-rulesengine.postman_collection.json"
    ENV_PATH="./postman-test/environment/support-rulesengine.postman_environment.json"

    echo "[info] ---------- use newman ----------"

    newman run ${COLLECTION_PATH} \
	   --folder rules -e ${ENV_PATH} \
	   -d ./postman-test/data/rulesengineData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder rules_error_5xx -e ${ENV_PATH} \
	   -d ./postman-test/data/rulesengineData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder ping -e ${ENV_PATH} \
	   -d ./postman-test/data/rulesengineData.json \
	   -r cli
fi

echo "Info:Rulesengine Test Completed."
