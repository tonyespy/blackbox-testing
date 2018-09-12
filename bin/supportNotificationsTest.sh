#!/bin/bash

_TESTMODE=${_TESTMODE:docker}

echo "Info: Initiating Support Notifications Test."

if [ "$_TESTMODE" == "docker" ] ; then

    COLLECTION_PATH="collections/support-notifications.postman_collection.json"
    ENV_PATH="environment/support-notification-docker.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"

    docker-compose run --rm postman run ${COLLECTION_PATH} --folder="subscription"  --environment=${ENV_PATH} --reporters="junit,cli"
    docker-compose run --rm postman run ${COLLECTION_PATH} --folder="notification"  --environment=${ENV_PATH} --reporters="junit,cli"
    docker-compose run --rm postman run ${COLLECTION_PATH} --folder="transmission"  --environment=${ENV_PATH} --reporters="junit,cli"
    docker-compose run --rm postman run ${COLLECTION_PATH} --folder="ping"  --environment=${ENV_PATH} --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    COLLECTION_PATH="./postman-test/collections/support-notifications.postman_collection.json"
    ENV_PATH="./postman-test/environment/support-notification.postman_environment.json"

    echo "[info] ---------- use newman ----------"

    newman run ${COLLECTION_PATH} \
	   --folder subscription -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder notification -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder transmission -e ${ENV_PATH} \
	   -d ./postman-test/data/readingData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder ping -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli
fi
