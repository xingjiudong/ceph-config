#!/bin/bash
set -e

ETCD_CLIENT_IP=$1
CLUSTER_NAME=$2

docker run --rm \
-v /etc/ceph:/etc/ceph \
-e ETCD_CLIENT_IP=${ETCD_CLIENT_IP:-127.0.0.1} \
-e CLUSTER=${CLUSTER_NAME:-ceph} \
xingjiudong/ceph-get-config

