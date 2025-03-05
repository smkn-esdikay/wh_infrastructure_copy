---
permalink: https://github.com/repo/infrastructure
title: PinTV Infrastructure
---

## AWS Logins
First Login to the main PinTV Account at https://00001.signin.aws.amazon.com/console
* **Development: https://signin.aws.amazon.com/switchrole?account=00004&roleName=OrganizationAccountAccessRole&displayName=pintv-development**
* **Production: https://signin.aws.amazon.com/switchrole?account=00005&roleName=OrganizationAccountAccessRole&displayName=pintv-production**


## AWS Credential file

First Login to the main PinTV Account at https://747843472649.signin.aws.amazon.com/console and generate credentials
```
# pintv
[pintv-root]
# account 00001
output                = json
region                = us-east-1
aws_access_key_id     = <<YOUR KEYS>>
aws_secret_access_key = <<YOUR KEYS>>

[pintv-development-infra]
# 00004
output         = json
region         = us-east-1
source_profile = pintv-root
role_arn       = arn:aws:iam::00004:role/OrganizationAccountAccessRole

[pintv-development]
output         = json
region         = us-east-1
source_profile = pintv-root
role_arn       = arn:aws:iam::00004:role/OrganizationAccountAccessRole

[pintv-production-infra]
# 00005
output         = json
region         = us-east-1
source_profile = pintv-root
role_arn       = arn:aws:iam::00005:role/OrganizationAccountAccessRole

[pintv-production]
# 00005
output         = json
region         = us-east-1
source_profile = pintv-root
role_arn       = arn:aws:iam::00005:role/OrganizationAccountAccessRole
```

## AWS Cli Connectivity
aws cli - root
```
aws --profile pintv-root sts get-caller-identity   
{
    "UserId": "AZZZZ1",
    "Account": "00001",
    "Arn": "arn:aws:iam::00001:user/mm"
```

aws cli - development
```
aws --profile pintv-development sts get-caller-identity
{
    "UserId": "AZZZZ2:botocore-session-00002",
    "Account": "00004",
    "Arn": "arn:aws:sts::00004:assumed-role/OrganizationAccountAccessRole/botocore-session-00002"
}
```

aws cli - production
```
aws --profile pintv-production sts get-caller-identity
{
    "UserId": "AZZZZ3:botocore-session-00003",
    "Account": "00005",
    "Arn": "arn:aws:sts::00005:assumed-role/OrganizationAccountAccessRole/botocore-session-00003"
}
```

## Terraform Installation
Install tfenv https://formulae.brew.sh/formula/tfenv

```brew install tfenv
tfenv install v1.1.9
tfenv use v1.1.9
```

## EKS Cluster Access
development kubeconfig
```
aws --profile pintv-development eks --region us-east-1  update-kubeconfig --name eks-development-us-east-1
```

development test access
```
kubectl config current-context
arn:aws:eks:us-east-1:00004:cluster/eks-development-us-east-1

kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE   IP              NODE                            NOMINATED NODE   READINESS GATES
kube-system   aws-node-5ctjg             2/2     Running   0          82m   10.106.34.222   ip-10-106-34-222.ec2.internal   <none>           <none>
kube-system   aws-node-9g4bn             2/2     Running   0          82m   10.106.21.22    ip-10-106-21-22.ec2.internal    <none>           <none>
kube-system   aws-node-cv89m             2/2     Running   0          82m   10.106.31.4     ip-10-106-31-4.ec2.internal     <none>           <none>
kube-system   aws-node-klnhk             2/2     Running   0          82m   10.106.25.35    ip-10-106-25-35.ec2.internal    <none>           <none>
kube-system   coredns-86969bccb4-76lvk   1/1     Running   0          88m   10.106.24.77    ip-10-106-25-35.ec2.internal    <none>           <none>
kube-system   coredns-86969bccb4-ndk8l   1/1     Running   0          88m   10.106.27.225   ip-10-106-25-35.ec2.internal    <none>           <none>
kube-system   kube-proxy-6rbtq           1/1     Running   0          82m   10.106.34.222   ip-10-106-34-222.ec2.internal   <none>           <none>
kube-system   kube-proxy-8j8sf           1/1     Running   0          82m   10.106.25.35    ip-10-106-25-35.ec2.internal    <none>           <none>
kube-system   kube-proxy-jh92m           1/1     Running   0          82m   10.106.21.22    ip-10-106-21-22.ec2.internal    <none>           <none>
kube-system   kube-proxy-vmcvs           1/1     Running   0          82m   10.106.31.4     ip-10-106-31-4.ec2.internal     <none>           <none>
```

## Apps
The apps are deployed with flux and helm, and the files are in `kubernetes/flux/development`

## SOPS

The secret file is in the respective directories of each app

Backend: `kubernetes/flux/development/backend/backend-secrets.yaml`

Frontend: `kubernetes/flux/development/frontend/frontend-secrets.yaml`

To decrypt the secret, simply enter the directory where the secret is and run:

```
sops -d backend-secrets.yaml
```

Edit the secrets as necessary and encrypt the file using the command

```
sops -e -i backend-secrets.yaml
```

> Note that you need to have the AWS CLI configured with AWS access because sops will use the kms key to encrypt and decrypt the file