#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

_TESTMODE=${_TESTMODE:docker}

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

echo "Info: Initiating Export-Client Test."

if [ "$_TESTMODE" == "docker" ] ; then

    COLLECTION_PATH="collections/export-client.postman_collection.json"
    ENV_PATH="environment/export-client-docker.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"
    
    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="registration" --iteration-data="data/exportClientData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="registration_error_4xx" --iteration-data="data/exportClientData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="ping" --iteration-data="data/exportClientData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    echo "[info] ---------- use newman ----------"

    COLLECTION_PATH="./postman-test/collections/export-client.postman_collection.json"
    ENV_PATH="./postman-test/environment/export-client.postman_environment.json"

    newman run ${COLLECTION_PATH} \
	   --folder registration -e ${ENV_PATH} \
	   -d ./postman-test/data/exportClientData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder registration_error_4xxx -e ${ENV_PATH} \
	   -d ./postman-test/data/exportClientData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder ping -e -e ${ENV_PATH} \
	   -d ./postman-test/data/exportClientData.json \
	   -r cli
fi

echo "Info: Export-Client Test Completed."
