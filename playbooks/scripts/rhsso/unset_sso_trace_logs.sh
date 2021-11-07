#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |grep Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | grep -v acl | awk '{print $1}');do oc -n $NAMESPACE rsh $i /opt/eap/bin/jboss-cli.sh -c --commands="/subsystem=logging/logger=org.infinispan:remove"
done


for i in $(check_pods | grep -v acl | awk '{print $1}');do oc -n $NAMESPACE rsh $i /opt/eap/bin/jboss-cli.sh -c --commands="/subsystem=logging/logger=org.jgroups:remove"
done
fi

