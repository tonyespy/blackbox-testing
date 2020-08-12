#!/bin/bash

BASE_PATH="./postman-test"
COLLECTION_PATH=${BASE_PATH}"/collections/core-metadata-importer.postman_collection.json"
ENV_PATH=${BASE_PATH}"/environment/snap-core-metadata-docker.postman_environment.json"

echo "Info: import CoreMetadata's test data."

newman run ${COLLECTION_PATH} --environment=${ENV_PATH}

echo "Info: CoreMetadata's test data imported"
