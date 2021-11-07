#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso
CONF_DIR=../result_collections/rhsso/configuration-$APP-$(date +%Y-%m-%d)
mkdir -p $CONF_DIR

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |grep Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | grep -v acl | awk '{print $1}');do oc -n $NAMESPACE rsync $i:/opt/eap/standalone/configuration/  $CONF_DIR/
done
fi
