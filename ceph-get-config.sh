#!/bin/bash
set -e

ETCD_CLIENT_IP=$1
CLUSTER=$2

docker run --rm \
-v /etc/ceph:/tmp/ceph \
-e ETCD_CLIENT_IP=${ETCD_CLIENT_IP:-127.0.0.1} \
-e CLUSTER=${CLUSTER_NAME:-ceph} \
xingjiudong/ceph-get-config
