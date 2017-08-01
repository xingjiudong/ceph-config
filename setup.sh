#!/bin/bash
set -e

sed -r "s/@CLUSTER@/${CLUSTER:-ceph}/g" /etc/confd/conf.d/ceph.conf.toml.in > /etc/confd/conf.d/ceph.conf.toml
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP:-127.0.0.1}:2379 --prefix="/ceph-config/${CLUSTER:-ceph}" > /dev/null 2>&1

etcdctl  --peers http://${ETCD_CLIENT_IP:-127.0.0.1}:2379 get  /ceph-config/${CLUSTER:-ceph}/adminKeyring  > /etc/ceph/${CLUSTER:-ceph}.client.admin.keyring

cp /etc/ceph/${CLUSTER:-ceph}.conf  /tmp/ceph/${CLUSTER:-ceph}.conf
cp /etc/ceph/${CLUSTER:-ceph}.client.admin.keyring /tmp/ceph/${CLUSTER:-ceph}.client.admin.keyring
