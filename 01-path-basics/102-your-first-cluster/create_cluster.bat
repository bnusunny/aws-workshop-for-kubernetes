
REM change this to your aws-cli profile name
set AWS_PROFILE=default
set AWS_DEFAULT_REGION=cn-northwest-1
set AWS_REGION=%AWS_DEFAULT_REGION%

REM change this to your S3 bucket
set KOPS_STATE_STORE=s3://kops-state-store-<iam_id>


REM change this to your iam_id 
set cluster_name=<iam_id>.zhy.k8s.local

REM official CoreOS AMI
REM CoreOS 1800.7.0
set ami=ami-02a5768104b4e8d4c

REM change this to your vpcid
set vpcid=vpc-f6ed5b9f

REM change this to your private subnet ids
set SUBNET_IDS="subnet-69349c00,subnet-86d914fd,subnet-46557c0c"

REM change this to your public subnet ids
set UTILITY_SUBNET_IDS="subnet-68349c01,subnet-95d815ee,subnet-d0557c9a"

set KUBERNETES_VERSION=v1.10.3
set KOPS_VERSION=1.10.0
set kubernetesVersion=https://s3.cn-north-1.amazonaws.com.cn/kubernetes-release/release/%KUBERNETES_VERSION%

set KOPS_BASE_URL=https://s3.cn-north-1.amazonaws.com.cn/kubeupv2/kops/%KOPS_VERSION%/
set NODEUP_URL=%KOPS_BASE_URL%linux/amd64/nodeup
set PROTOKUBE_IMAGE=%KOPS_BASE_URL%images/protokube.tar.gz

kops create cluster ^
     --name=%cluster_name% ^
     --image=%ami% ^
     --cloud=aws ^
     --topology private ^
     --zones=cn-northwest-1a,cn-northwest-1b,cn-northwest-1c ^
     --master-count=3 ^
     --master-size="t2.small" ^
     --node-count=3 ^
     --node-size="t2.small"  ^
     --vpc=%vpcid% ^
     --subnets=%SUBNET_IDS% ^
     --utility-subnets=%UTILITY_SUBNET_IDS% ^
     --networking=flannel-vxlan ^
     --kubernetes-version=%kubernetesVersion% ^
     --ssh-public-key=%USERPROFILE%\.ssh\id_rsa.pub

