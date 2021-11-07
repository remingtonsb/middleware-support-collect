# middleware-support-collect

This repository store an amount of Ansible Playbooks to scnenários where you using:

Datagrid or rhsso running on Openshift

Tested in following scenário

- Openshift 4.x
- Datagrid 7.3 based in Template installation
- RHSSO 7.4  based in Template installation

Because all commands in Playbooks calling shell scripts using "oc-client" the hosts always point to "localhost".

Example:

- name: collect heap dump from all rhsso containers
  hosts: 127.0.0.1
  connection: local
  tasks:
  - name:
    shell: sh ../scripts/rhsso/get_heap_dump.sh
    async: 600
    poll: 0


This Ansible Playbooks is only used to controll shell scripts to collect informations about:

- Get thread dumps
- Get Heap dumps
- Get config files
- Get logs (GC logs, server log, audit logs)

By default other 2 playbooks/shell scripts are disabled in main-sso.yaml and main-datagrid.yaml

- Set trace logs (Set inifinispan and jgroups logs as TRACE)
- Unset trace logs (Unset inifinispan and jgroups logs as TRACE)

About main-sso.yaml 

The main-sso.yaml and main-datagrid.yaml laybook controlles executions of another playbooks:

playbooks/
├── datagrid
│   ├── collect_config_datagrid.yaml
│   ├── collect_heap_dump.yaml
│   ├── collect_logs_datagrid.yaml
│   ├── collect_thread_dump.yaml
│   ├── set_trace-logs_datagrid.yaml
│   └── unset_trace-logs_datagrid.yaml
├── hosts
├── keys
├── main-datagrid.yaml
├── main-sso.yaml
├── rhsso
│   ├── collect_config_sso.yaml
│   ├── collect_heap_dump.yaml
│   ├── collect_logs_sso.yaml
│   ├── collect_thread_dump.yaml
│   ├── set_trace-logs_sso.yaml
│   └── unset_trace-logs_sso.yaml
└── scripts
    ├── datagrid
    │   ├── get_configs-datagrid.sh
    │   ├── get_heap_dump.sh
    │   ├── get_logs_datagrid.sh
    │   ├── get_thread_dump.sh
    │   ├── set_trace_logs-datagrid.sh
    │   └── unset_trace_logs-datagrid.sh
    └── rhsso
        ├── get_configs-sso.sh
        ├── get_heap_dump.sh
        ├── get_logs_sso.sh
        ├── get_thread_dump.sh
        ├── set_trace_logs-sso.sh
        └── unset_trace_logs-sso.sh


