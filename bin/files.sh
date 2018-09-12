#!/bin/bash

TIMESTAMPFORMAT=`date +%d-%m-%Y_%H%M%S`

CONFIGFILE=$(dirname "$0")/config.sh

_ROOTDIR=${_ROOTDIR:-/etc/newman}

EVENTDATAFILE="$_ROOTDIR"/data/eventData.json
COREDATAENVFILE="$_ROOTDIR"/environment/CoredataEnv.postman_environment.json
COREDATACOLLFILE="$_ROOTDIR"/collections/core-data.postman_collection.json
EVENTDATADUMP="$_ROOTDIR"/DataDumps/coredata/eventDb.json
READINGDATADUMP="$_ROOTDIR"/DataDumps/coredata/readingDb.json
VDDATADUMP="$_ROOTDIR"/DataDumps/coredata/valueDescriptorDb.json
READINGDATAFILE="$_ROOTDIR"/data/readingData.json
VDDATAFILE="$_ROOTDIR"/data/valueDescriptorData.json

METADATA_ENVFILE="$_ROOTDIR"/environment/MetadataEnv.postman_environment.json
METADATA_COLLFILE="$_ROOTDIR"/collections/core-metadata.postman_collection.json
ADDRESSABLE_DATAFILE="$_ROOTDIR"/data/addressableData.json
ADDRESSABLE_DATADUMP="$_ROOTDIR"/DataDumps/metadata/addressableDb.json
DEVICE_DATAFILE="$_ROOTDIR"/data/deviceData.json
DEVICE_DATADUMP="$_ROOTDIR"/DataDumps/metadata/deviceDb.json
DEVICESERVICE_DATAFILE="$_ROOTDIR"/data/deviceServiceData.json
DEVICESERVICE_DATADUMP="$_ROOTDIR"/DataDumps/metadata/deviceserviceDb.json
COMMAND_DATAFILE="$_ROOTDIR"/data/commandData.json
COMMAND_DATADUMP="$_ROOTDIR"/DataDumps/metadata/commandDb.json
DEVICEMANAGER_DATAFILE="$_ROOTDIR"/data/deviceManagerData.json
DEVICEMANAGER_DATADUMP="$_ROOTDIR"/DataDumps/metadata/deviceManagerDb.json
DEVICEPROFILE_DATAFILE="$_ROOTDIR"/data/deviceProfileData.json
DEVICEPROFILE_DATADUMP="$_ROOTDIR"/DataDumps/metadata/deviceProfileDb.json
PROVISION_DATAFILE="$_ROOTDIR"/data/provisionWatcherData.json
PROVISION_DATADUMP="$_ROOTDIR"/DataDumps/metadata/provisioWatcherDb.json
DEVICEREPORT_DATAFILE="$_ROOTDIR"/data/deviceReportData.json
DEVICEREPORT_DATADUMP="$_ROOTDIR"/DataDumps/metadata/deviceReportDb.json
SCHEDULE_DATAFILE="$_ROOTDIR"/data/scheduleData.json
SCHEDULE_DATADUMP="$_ROOTDIR"/DataDumps/metadata/scheduleDb.json
SCHEDULEEVENT_DATAFILE="$_ROOTDIR"/data/scheduleEventData.json
SCHEDULEEVENT_DATADUMP="$_ROOTDIR"/DataDumps/metadata/scheduleEventDb.json

CORECOMMANDENVFILE="$_ROOTDIR"/environment/command.postman_environment.json
CORECOMMANDCOLLFILE="$_ROOTDIR"/collections/core-command.postman_collection.json
ADDRESSABLECCDATADUMP="$_ROOTDIR"/DataDumps/command/addressableDb.json
DEVICECCDATADUMP="$_ROOTDIR"/DataDumps/command/deviceDb.json
DEVICEPROFILECCDATADUMP="$_ROOTDIR"/DataDumps/command/deviceProfileDb.json
DEVICESERVICECCDATADUMP="$_ROOTDIR"/DataDumps/command/deviceServiceDb.json
COMMANDCCDATADUMP="$_ROOTDIR"/DataDumps/command/commandDb.json
CORECOMMANDDATAFILE="$_ROOTDIR"/data/coreCommandData.json

REGISTERDATADUMP="$_ROOTDIR"/DataDumps/exportclient/exportConfigurationDb.json
LOGGINGDATADUMP="$_ROOTDIR"/DataDumps/logging/logEntryDb.json

SUPPORTNOTIFICATION_NOTIFICATION_DATADUMP="$_ROOTDIR"/DataDumps/supportNotifications/notificationDb.json
SUPPORTNOTIFICATION_SUBSCRIPTION_DATADUMP="$_ROOTDIR"/DataDumps/supportNotifications/subscriptionDb.json
SUPPORTNOTIFICATION_TRANSMISSION_DATADUMP="$_ROOTDIR"/DataDumps/supportNotifications/transmissionDb.json

if [ -f $CONFIGFILE ]; then

	source $CONFIGFILE

else 
	echo "Error: Configuration script does not exist."
	exit $?

fi

#EVENTREPORT200FILE=$eventReportPath200Status/event$TIMESTAMPFORMAT.html
#EVENTREPORT4XXFILE=$eventReportPath4XXStatus/event$TIMESTAMPFORMAT.html
#READINGREPORT200FILE=$readingReportPath200Status/reading$TIMESTAMPFORMAT.html
#READINGREPORT4XXFILE=$readingReportPath4XXStatus/reading$TIMESTAMPFORMAT.html
#VDREPORT200FILE=$vdReportPath200Status/valuedescriptor$TIMESTAMPFORMAT.html
#VDREPORT4XXFILE=$vdReportPath4XXStatus/valuedescriptor$TIMESTAMPFORMAT.html
#
#ADDRESSABLE_200FILE=$addressableReportPath200Status/addressable$TIMESTAMPFORMAT.html
#ADDRESSABLE_4XXFILE=$addressableReportPath4XXStatus/addressable$TIMESTAMPFORMAT.html
#COMMAND_200FILE=$commandReportPath200Status/command$TIMESTAMPFORMAT.html
#COMMAND_4XXFILE=$commandReportPath4XXStatus/command$TIMESTAMPFORMAT.html
#DEVICE_200FILE=$deviceReportPath200Status/device$TIMESTAMPFORMAT.html
#DEVICE_4XXFILE=$deviceReportPath4XXStatus/device$TIMESTAMPFORMAT.html
#DEVICEMANAGER_200FILE=$deviceManagerPath200Status/deviceManager$TIMESTAMPFORMAT.html
#DEVICEMANAGER_4XXFILE=$deviceManagerPath4XXStatus/deviceManager$TIMESTAMPFORMAT.html
#DEVICEPROFILE_200FILE=$deviceProfileReportPath200Status/deviceProfile$TIMESTAMPFORMAT.html
#DEVICEPROFILE_4XXFILE=$deviceProfileReportPath4XXStatus/deviceProfile$TIMESTAMPFORMAT.html
#DEVICEREPORT_200FILE=$deviceRepReportPath200Status/deviceReport$TIMESTAMPFORMAT.html
#DEVICEREPORT_4XXFILE=$deviceRepReportPath4XXStatus/deviceReport$TIMESTAMPFORMAT.html
#DEVICESERVICE_200FILE=$deviceServiceReportPath200Status/deviceService$TIMESTAMPFORMAT.html
#DEVICESERVICE_4XXFILE=$deviceServiceReportPath4XXStatus/deviceService$TIMESTAMPFORMAT.html
#PROVISIONWATCHER_200FILE=$provisionWatcherReportPath200Status/provisionWatcher$TIMESTAMPFORMAT.html
#PROVISIONWATCHER_4XXFILE=$provisionWatcherReportPath4XXStatus/provisionWatcher$TIMESTAMPFORMAT.html
#SCHEDULE_200FILE=$scheduleReportPath200Status/schedule$TIMESTAMPFORMAT.html
#SCHEDULE_4XXFILE=$scheduleReportPath4XXStatus/schedule$TIMESTAMPFORMAT.html
#SCHEDULEEVENT_200FILE=$scheduleEventReportPath200Status/scheduleEvent$TIMESTAMPFORMAT.html
#SCHEDULEEVENT_4XXFILE=$scheduleEventReportPath4XXStatus/scheduleEvent$TIMESTAMPFORMAT.html
#
#DEVICECCREPORT200FILE=$deviceCcReportPath200Status/device$TIMESTAMPFORMAT.html
#DEVICECCREPORT4XXFILE=$deviceCcReportPath4XXStatus/device$TIMESTAMPFORMAT.html

EVENTREPORT200FILE=$eventReportPath200Status/event$TIMESTAMPFORMAT.xml
EVENTREPORT4XXFILE=$eventReportPath4XXStatus/event$TIMESTAMPFORMAT.xml
READINGREPORT200FILE=$readingReportPath200Status/reading$TIMESTAMPFORMAT.xml
READINGREPORT4XXFILE=$readingReportPath4XXStatus/reading$TIMESTAMPFORMAT.xml
VDREPORT200FILE=$vdReportPath200Status/valuedescriptor$TIMESTAMPFORMAT.xml
VDREPORT4XXFILE=$vdReportPath4XXStatus/valuedescriptor$TIMESTAMPFORMAT.xml

ADDRESSABLE_200FILE=$addressableReportPath200Status/addressable$TIMESTAMPFORMAT.xml
ADDRESSABLE_4XXFILE=$addressableReportPath4XXStatus/addressable$TIMESTAMPFORMAT.xml
COMMAND_200FILE=$commandReportPath200Status/command$TIMESTAMPFORMAT.xml
COMMAND_4XXFILE=$commandReportPath4XXStatus/command$TIMESTAMPFORMAT.xml
DEVICE_200FILE=$deviceReportPath200Status/device$TIMESTAMPFORMAT.xml
DEVICE_4XXFILE=$deviceReportPath4XXStatus/device$TIMESTAMPFORMAT.xml
DEVICEMANAGER_200FILE=$deviceManagerPath200Status/deviceManager$TIMESTAMPFORMAT.xml
DEVICEMANAGER_4XXFILE=$deviceManagerPath4XXStatus/deviceManager$TIMESTAMPFORMAT.xml
DEVICEPROFILE_200FILE=$deviceProfileReportPath200Status/deviceProfile$TIMESTAMPFORMAT.xml
DEVICEPROFILE_4XXFILE=$deviceProfileReportPath4XXStatus/deviceProfile$TIMESTAMPFORMAT.xml
DEVICEREPORT_200FILE=$deviceRepReportPath200Status/deviceReport$TIMESTAMPFORMAT.xml
DEVICEREPORT_4XXFILE=$deviceRepReportPath4XXStatus/deviceReport$TIMESTAMPFORMAT.xml
DEVICESERVICE_200FILE=$deviceServiceReportPath200Status/deviceService$TIMESTAMPFORMAT.xml
DEVICESERVICE_4XXFILE=$deviceServiceReportPath4XXStatus/deviceService$TIMESTAMPFORMAT.xml
PROVISIONWATCHER_200FILE=$provisionWatcherReportPath200Status/provisionWatcher$TIMESTAMPFORMAT.xml
PROVISIONWATCHER_4XXFILE=$provisionWatcherReportPath4XXStatus/provisionWatcher$TIMESTAMPFORMAT.xml
SCHEDULE_200FILE=$scheduleReportPath200Status/schedule$TIMESTAMPFORMAT.xml
SCHEDULE_4XXFILE=$scheduleReportPath4XXStatus/schedule$TIMESTAMPFORMAT.xml
SCHEDULEEVENT_200FILE=$scheduleEventReportPath200Status/scheduleEvent$TIMESTAMPFORMAT.xml
SCHEDULEEVENT_4XXFILE=$scheduleEventReportPath4XXStatus/scheduleEvent$TIMESTAMPFORMAT.xml

DEVICECCREPORT200FILE=$deviceCcReportPath200Status/device$TIMESTAMPFORMAT.xml
DEVICECCREPORT4XXFILE=$deviceCcReportPath4XXStatus/device$TIMESTAMPFORMAT.xml
