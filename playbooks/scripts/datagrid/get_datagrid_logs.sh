#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=datagrid
LOGS_DIR=../result_collections/datagrid/logs-$APP-$(date +%Y-%m-%d)
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

while ps aux | grep -E 'get_datagrid_thread_dump|get_datagrid_heap_dump' | grep -v grep; [ $? -eq 0 ];do echo "THREAD DUMP RODANDO"; sleep 2;done

for i in $(check_pods | grep -v acl | awk '{print $1}');do mkdir -p $LOGS_DIR/$i ; oc -n $NAMESPACE logs $i --previous > $LOGS_DIR/$i/$(date +%Y-%m-%d-%H-%M-%S)-previous-server.log ;oc -n $NAMESPACE rsync $i:/opt/datagrid/standalone/log/  $LOGS_DIR/$i/
done
fi
