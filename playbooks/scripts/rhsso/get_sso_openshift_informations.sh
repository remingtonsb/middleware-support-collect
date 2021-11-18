#!/bin/bash



NAMESPACE=datagrid-site-azure
APP=sso
OCP_DIR=../result_collections/rhsso/openshift-info-$APP-$(date +%Y-%m-%d)
mkdir -p $OCP_DIR
SECONDS=200

check_pods()
{
oc -n $NAMESPACE get pods | grep -v NAME | grep $APP |grep Running
}

check_pods

if [ $? -ne 0 ]; then
echo "No pods Running"
exit 1
else



while ps aux | grep -E 'get_sso_thread_dump|get_sso_heap_dump' | grep -v grep; [ $? -eq 0 ];do echo "" >> $OCP_DIR/ocp_data.txt; date >> $OCP_DIR/ocp_data.txt; echo "" >> $OCP_DIR/ocp_data.txt; echo "NODES" >> $OCP_DIR/ocp_data.txt ; oc adm top nodes >> $OCP_DIR/ocp_data.txt ;echo "PODS" >> $OCP_DIR/ocp_data.txt ;oc adm top pods >> $OCP_DIR/ocp_data.txt; sleep 2;done


fi
