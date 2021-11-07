# middleware-support-collect

This repository store an amount of Ansible Playbooks to scnenários where you using:

Datagrid or rhsso running on Openshift

Tested in following scenário

- Openshift 4.x
- Datagrid 7.3 based in Template installation
- RHSSO 7.4  based in Template installation

This Ansible Playbooks is only used to controll shell scripts to collect informations about:

Get thread dumps
Get Heap dumps
Get config files
Get logs (GC logs, server log, audit logs)

By default other 2 playbooks/shell scripts are disabled in main-sso.yaml and main-datagrid.yaml

Set trace logs (Set inifinispan and jgroups logs as TRACE)
unset trace logs (Unset inifinispan and jgroups logs as TRACE)
