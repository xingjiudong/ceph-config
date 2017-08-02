#!/bin/bash
set -e

: ${CLUSTER:=ceph}
: ${ETCD_CLIENT_IP}

sed -r "s/@CLUSTER@/${CLUSTER}/g" /etc/confd/conf.d/ceph.conf.toml.in > /etc/confd/conf.d/ceph.conf.toml
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP}:2379 --prefix="/ceph-config/${CLUSTER}"

etcdctl --endpoints http://${ETCD_CLIENT_IP}:2379 get  /ceph-config/${CLUSTER}/adminKeyring  > /etc/ceph/${CLUSTER}.client.admin.keyring
chmod 600 /etc/ceph/${CLUSTER}.client.admin.keyring
