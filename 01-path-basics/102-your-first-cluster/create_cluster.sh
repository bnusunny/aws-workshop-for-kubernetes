#!/bin/bash

source env.config

# change this to your id
cluster_name='<iam-id>.zhy.k8s.local'

# official CoreOS AMI
#ami='ami-e7958185'
#ami='ami-06a0b464'
# ami='ami-c9abbfab'
# CoreOS 1800.7.0
ami='ami-02a5768104b4e8d4c'

# change this to your vpcid
vpcid='vpc-1684337f'
# change this to your private subnet ids
SUBNET_IDS='subnet-da60c8b3,subnet-498e4332,subnet-ac84aae6'
# change this to your public subnet ids
UTILITY_SUBNET_IDS='subnet-4461c92d,subnet-8b8e43f0,subnet-7e85ab34'

KUBERNETES_VERSION='v1.10.3'
KOPS_VERSION='1.10.0'
kubernetesVersion="https://s3.cn-north-1.amazonaws.com.cn/kubernetes-release/release/$KUBERNETES_VERSION"

#export CNI_VERSION_URL="https://s3.cn-north-1.amazonaws.com.cn/kubernetes-release/network-plugins/cni-plugins-amd64-v0.6.0.tgz"
#export CNI_ASSET_HASH_STRING="d595d3ded6499a64e8dac02466e2f5f2ce257c9f"
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

