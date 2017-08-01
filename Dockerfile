FROM buildpack-deps:stretch-curl 
MAINTAINER XJD 25635680@qq.com

# Env information. 
ENV ETCD_VERSION v2.3.7
ENV CONFD_VERSION 0.11.0 
ENV ETCD_CLIENT_IP ""  
ENV CLUSTER "" 

# Install etcdctl.
RUN wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz --no-check-certificate && \
    tar xvzf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
    rm -rf etcd-${ETCD_VERSION}-linux-amd64
 
# Install Confd.
RUN wget https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 --no-check-certificate && \
    chmod +x confd-${CONFD_VERSION}-linux-amd64 && \
    mv confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd && \
    mkdir /etc/ceph

# Copy configuration file.
COPY ./confd /etc/confd
COPY ./setup.sh /

CMD ["/setup.sh"]
