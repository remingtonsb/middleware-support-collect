#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=datagrid
DATAGRID_DIR=/opt/datagrid
HEAP_DUMP_DIR=../result_collections/datagrid/$APP-heap-dumps-$(date +%Y-%m-%d)
mkdir -p $HEAP_DUMP_DIR

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP | grep -i Running
}

check_pods

set_pod_number_variables()
{
count=0; for i in $(check_pods |awk '{print $1}');do count=$((count+1)); export  POD_$count=$i;done 
}

set_pod_number_variables

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else

for i in $(check_pods | awk '{print $1}');do PID=`oc -n $NAMESPACE exec $i -- jcmd -l | grep org.jboss.as.standalone | awk '{print $1}'`;oc -n $NAMESPACE  exec $i -- mkdir -p /opt/eap/dumps/heap-dumps; oc -n $NAMESPACE  exec $i -- jcmd $PID GC.heap_dump /opt/eap/dumps/heap-dumps/$(date +%Y-%m-%d-%H-%M-%S)-$i-heap.hprof && oc -n $NAMESPACE rsync $i:/opt/eap/dumps/heap-dumps/ $HEAP_DUMP_DIR/ 
done
fi
