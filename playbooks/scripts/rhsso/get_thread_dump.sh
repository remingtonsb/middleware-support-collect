#!/bin/bash

NAMESPACE=datagrid-site-azure
APP=sso
SSO_DIR=/opt/eap
THREAD_DUMP_DIR=$PWD/$APP-thread-dumps-$(date +%Y-%m-%d)
mkdir -p $THREAD_DUMP_DIR

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |  grep -v deploy | grep -i Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | awk '{print $1}');do PID=`oc -n $NAMESPACE exec $i jps | grep jboss-modules | awk '{print $1}'`;oc -n $NAMESPACE  exec $i -- mkdir -p /opt/eap/dumps/thread-dumps ; oc -n $NAMESPACE  exec $i  -- bash -c "for x in {1..10};do jstack -l $PID >> /opt/eap/dumps/thread-dumps/$(date +%Y-%m-%d-%H-%M-%S)-$i-jstack.out; sleep 2; done" &&  oc -n $NAMESPACE rsync $i:/opt/eap/dumps/thread-dumps/ $THREAD_DUMP_DIR/
done
fi
