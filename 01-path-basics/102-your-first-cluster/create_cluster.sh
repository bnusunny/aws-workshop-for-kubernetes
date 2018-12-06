#!/bin/bash

source env.config

# change this to your id
cluster_name='<iam_id>.zhy.k8s.local'

# official CoreOS AMI
# CoreOS 1800.7.0
ami='ami-02a5768104b4e8d4c'

# change this to your vpcid
vpcid='vpc-f6ed5b9f'
# change this to your private subnet ids
SUBNET_IDS='subnet-69349c00,subnet-86d914fd,subnet-46557c0c'
# change this to your public subnet ids
UTILITY_SUBNET_IDS='subnet-68349c01,subnet-95d815ee,subnet-d0557c9a'

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
     --master-count=3 \
     --master-size="t2.small" \
     --node-count=3 \
     --node-size="t2.small"  \
     --vpc=${vpcid} \
     --subnets=${SUBNET_IDS} \
     --utility-subnets=${UTILITY_SUBNET_IDS} \
     --networking=flannel-vxlan \
     --kubernetes-version="$kubernetesVersion" \
     --ssh-public-key="~/.ssh/id_rsa.pub"

