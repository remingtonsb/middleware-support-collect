#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso
LOGS_DIR=../result_collections/rhsso/logs-$APP-$(date +%Y-%m-%d)
mkdir -p $LOGS_DIR

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |grep Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | grep -v acl | awk '{print $1}');do mkdir  $LOGS_DIR/$i ;oc logs $i > $LOGS_DIR/$i/$(date +%Y-%m-%d-%H-%M-%S)-server.log;oc logs $i --previous > $LOGS_DIR/$i/$(date +%Y-%m-%d-%H-%M-%S)-previous-server.log ;oc -n $NAMESPACE rsync $i:/opt/eap/standalone/log/  $LOGS_DIR/$i/
done
fi
