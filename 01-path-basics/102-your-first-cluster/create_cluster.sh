#!/bin/bash

source env.config

# change this to your id
cluster_name='harold.cartechfin.k8s.local'

# official CoreOS AMI
# CoreOS 1800.7.0
ami='ami-02a5768104b4e8d4c'

# change this to your vpcid
vpcid='vpc-1784337e'
# change this to your private subnet ids
SUBNET_IDS='subnet-4761c92e,subnet-d68e43ad,subnet-f285abb8'
# change this to your public subnet ids
UTILITY_SUBNET_IDS='subnet-fa61c993,subnet-898e43f2,subnet-1684aa5c'

KUBERNETES_VERSION='v1.10.3'
KOPS_VERSION='1.10.0'
kubernetesVersion="https://s3.cn-north-1.amazonaws.com.cn/kubernetes-release/release/$KUBERNETES_VERSION"

export KOPS_BASE_URL=https://s3.cn-north-1.amazonaws.com.cn/kubeupv2/kops/${KOPS_VERSION}/
export NODEUP_URL=${KOPS_BASE_URL}linux/amd64/nodeup
export PROTOKUBE_IMAGE=${KOPS_BASE_URL}images/protokube.tar.gz

kops create cluster \
     --name=${cluster_name} \
     --image=${ami} \
     --cloud=aws \
     --topology private \
     --zones=cn-northwest-1a,cn-northwest-1b,cn-northwest-1c \
     --master-count=1 \
     --master-size="t2.medium" \
     --node-count=2 \
     --node-size="t2.medium"  \
     --vpc=${vpcid} \
     --subnets=${SUBNET_IDS} \
     --utility-subnets=${UTILITY_SUBNET_IDS} \
     --networking="flannel-vxlan" \
     --kubernetes-version="$kubernetesVersion" \
     --ssh-public-key="~/.ssh/id_rsa.pub"  

