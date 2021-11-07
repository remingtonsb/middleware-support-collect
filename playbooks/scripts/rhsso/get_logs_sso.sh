#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso
LOGS_DIR=$PWD/logs-$APP-$(date +%Y-%m-%d)
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

for i in $(check_pods | grep -v acl | awk '{print $1}');do mkdir  $LOGS_DIR/$i ;oc -n $NAMESPACE rsync $i:/opt/eap/standalone/log/  $LOGS_DIR/$i/
done
fi
