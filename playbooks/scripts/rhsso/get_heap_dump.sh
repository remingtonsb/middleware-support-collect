#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso
SSO_DIR=/opt/eap
HEAP_DUMP_DIR=$PWD/$APP-heap-dumps-$(date +%Y-%m-%d)
mkdir -p $HEAP_DUMP_DIR

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |  grep -v deploy | grep -i Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | awk '{print $1}');do PID=`oc -n $NAMESPACE exec $i jps | grep jboss-modules | awk '{print $1}'`;oc -n $NAMESPACE  exec $i -- mkdir -p /opt/eap/dumps/heap-dumps ;oc -n $NAMESPACE  exec $i -- jcmd $PID GC.heap_dump /opt/eap/dumps/heap-dumps/$(date +%Y-%m-%d-%H-%M-%S)-$i-heap.hprof && oc -n $NAMESPACE rsync $i:/opt/eap/dumps/heap-dumps/ $HEAP_DUMP_DIR/
done
fi
