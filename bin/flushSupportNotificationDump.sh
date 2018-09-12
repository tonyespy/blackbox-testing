#!/bin/bash

DATA_BASE="notifications"

if [ "$SNAPTEST" == "true" ] ; then
    FLUSH_SCRIPT=postman-test/javascript/supportNotifications/flushScript.js

    COMMAND="edgexfoundry.mongo"
else
    FLUSH_SCRIPT=/etc/newman/javascript/supportNotifications/flushScript.js

    COMMAND="docker-compose exec -T mongo /bin/bash -c mongo"
fi

${COMMAND} ${DATA_BASE} ${FLUSH_SCRIPT}
