#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

_TESTMODE=${_TESTMODE:docker}

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

echo "Info: Initiating Coredata Test."

if [ "$_TESTMODE" == "docker" ] ; then

    COLLECTION_PATH="collections/core-data.postman_collection.json"
    ENV_PATH="environment/CoredataEnv.postman_environment.json"

    echo "[info] ---------- use docker-compose run postman ----------"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="event" --iteration-data="data/eventData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"
    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="event_error_4xx" --iteration-data="data/eventData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="reading" --iteration-data="data/readingData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"
    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="reading_error_4xx" --iteration-data="data/readingData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="valuedescriptor" --iteration-data="data/valueDescriptorData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

    docker-compose run --rm postman run ${COLLECTION_PATH} \
        --folder="valuedescriptor_error_4xx" --iteration-data="data/valueDescriptorData.json" --environment=${ENV_PATH} \
        --reporters="junit,cli"

elif [ "$_TESTMODE" == "newman" ] ; then

    COLLECTION_PATH="./postman-test/collections/core-data.postman_collection.json"
    ENV_PATH="./postman-test/environment/CoredataEnv.postman_environment.json"

    echo "[info] ---------- use newman ----------"

    newman run ${COLLECTION_PATH} \
	   --folder event -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder event_error_4xx -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder reading -e ${ENV_PATH} \
	   -d ./postman-test/data/readingData.json \
	   -r cli

    newman run ${COLLECTION_PATH} \
	   --folder reading_error_4xx -e ${ENV_PATH} \
	   -d ./postman-test/data/eventData.json \
	   -r cli
fi

#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="event" --iteration-data="data/eventData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"
#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="event_error_4xx" --iteration-data="data/eventData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"
#
#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="reading" --iteration-data="data/readingData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"
#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="reading_error_4xx" --iteration-data="data/readingData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"
#
#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="valuedescriptor" --iteration-data="data/valueDescriptorData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"
#docker run --rm --user="1000" -v "${PWD}/bin/postman-test":/etc/newman --network=${DOCKER_NETWORK} postman/newman_ubuntu1404 run ${COLLECTION_PATH} \
#    --folder="valuedescriptor_error_4xx" --iteration-data="data/valueDescriptorData.json" --environment=${ENV_PATH} \
#    --reporters="junit,cli"





#    WORKSPACE=/Users/bruce/Documents/eclipse-workspace/deploy-edgeX/
#
#	echo "[info] not jenkins build"

#newman run $COREDATACOLLFILE --folder event -d $EVENTDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $EVENTREPORT200FILE
#
#newman run $COREDATACOLLFILE --folder reading -d $READINGDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $READINGREPORT200FILE
#
#newman run $COREDATACOLLFILE --folder valuedescriptor -d $VDDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $VDREPORT200FILE
#
#newman run $COREDATACOLLFILE --folder event_error_4xx -d $EVENTDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $EVENTREPORT4XXFILE
#
#newman run $COREDATACOLLFILE --folder reading_error_4xx -d $READINGDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $READINGREPORT4XXFILE
#
#newman run $COREDATACOLLFILE --folder valuedescriptor_error_4xx -d $VDDATAFILE -e $COREDATAENVFILE -r cli,html --reporter-html-export $VDREPORT4XXFILE

echo "Info:Coredata Test Completed."
