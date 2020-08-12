#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh

BASE_PATH="../postman-test"
COLLECTION_PATH=${BASE_PATH}"/collections/core-metadata.postman_collection.json"
ENV_PATH=${BASE_PATH}"/environment/snap-core-metadata-docker-security.postman_environment.json"

#if [ -f $NAMESFILE ]; then
#
#	. $NAMESFILE
#
#else
#	echo "Error: Names file does not exist."
#	exit $?
#
#fi

echo "Info: Initiating Metadata Test."

echo "[info] ---------- use newman ----------"

source $(dirname "$0")/security/setupSecurityAccount.sh -useradd

echo "[info] ======================== Start run metaData test - addressable ========================"

newman run ${COLLECTION_PATH} \
    --folder="addressable" --iteration-data=${BASE_PATH}"/data/addressableData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"
    
newman run ${COLLECTION_PATH} \
    --folder="addressable_error_4xx" --iteration-data=${BASE_PATH}"/data/addressableData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - command ========================"

newman run ${COLLECTION_PATH} \
    --folder="command" --iteration-data=${BASE_PATH}"/data/commandData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="command_error_4xx" --iteration-data=${BASE_PATH}"/data/commandData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - device ========================"

newman run ${COLLECTION_PATH} \
    --folder="device" --iteration-data=${BASE_PATH}"/data/deviceData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="device_error_4xx" --iteration-data=${BASE_PATH}"/data/deviceData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - deviceprofile ========================"

newman run ${COLLECTION_PATH} \
    --folder="deviceprofile" --iteration-data=${BASE_PATH}"/data/deviceProfileData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="deviceprofile_error_4xx" --iteration-data=${BASE_PATH}"/data/deviceProfileData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - devicereport ========================"

newman run ${COLLECTION_PATH} \
    --folder="devicereport" --iteration-data=${BASE_PATH}"/data/deviceReportData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="devicereport_error_4xx" --iteration-data=${BASE_PATH}"/data/deviceReportData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - deviceservice ========================"

newman run ${COLLECTION_PATH} \
    --folder="deviceservice" --iteration-data=${BASE_PATH}"/data/deviceServiceData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="deviceservice_error_4xx" --iteration-data=${BASE_PATH}"/data/deviceServiceData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

echo "[info] ======================== Start run metaData test - provisionwatcher ========================"

newman run ${COLLECTION_PATH} \
    --folder="provisionwatcher" --iteration-data=${BASE_PATH}"/data/provisionWatcherData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

newman run ${COLLECTION_PATH} \
    --folder="provisionwatcher_error_4xx" --iteration-data=${BASE_PATH}"/data/provisionWatcherData.json" --environment=${ENV_PATH} \
    --reporters="junit,cli" --insecure --global-var accessToken="$TOKEN"

#source $(dirname "$0")/security/setupSecurityAccount.sh -userdel

echo "Info: Metadata Test completed."

