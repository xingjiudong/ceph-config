#!/bin/bash
set -e

sed -r "s/@CLUSTER@/${CLUSTER:-ceph}/g" /etc/confd/conf.d/ceph.conf.toml.in > /etc/confd/conf.d/ceph.conf.toml
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP:-127.0.0.1}:2379 --prefix="/ceph-config/${CLUSTER:-ceph}" > /dev/null 2>&1

etcdctl  --peers http://172.23.7.63:2379 get  /ceph-config/ceph/adminKeyring  > /etc/ceph/ceph.client.admin.keyring

cp /etc/ceph/ceph.conf /tmp/ceph/ceph.conf
cp /etc/ceph/ceph.client.admin.keyring /tmp/ceph/ceph.client.admin.keyring
