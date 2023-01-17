# cloudifytests Infrastructure
## Overview
Cloud Browser is a Kubernetes compatible platform for executing automation test cases.

## Prerequisite
**kubectl –** A command line tool for working with Kubernetes clusters.

**eksctl –** A command line tool for working with EKS clusters that automates many individual tasks.

**Required AWS IAM permissions –** The IAM security principal that you're using must have permissions to work with Amazon EKS IAM roles and service linked roles, AWS CloudFormation, and a VPC and related resources.

## Steps to add infrastructure to your local

Git clone the project:

       $ git clone https://github.com/cloudifytestss/cloudify_infra.git
 
Create cluster using following command.

        $ eksctl create cluster -f cluster.yaml

To patch the core-dns deployment with taints and tolleration use the following command.

        $ kubectl patch deployment coredns -p \
        '{"spec":{"template":{"spec":{"tolerations":[{"effect":"NoSchedule","key":"cloudifytests","value":"true"}]}}}}' -n kube-system
Use following command for auto-scaling the cluster:

        $ helm repo add autoscaler https://kubernetes.github.io/autoscaler
        $ helm install my-release autoscaler/cluster-autoscaler \
        --set  'autoDiscovery.clusterName'=cloudifytests \
        --set tolerations[0].key=cloudifytests \
        --set-string tolerations[0].value=true \
        --set tolerations[0].operator=Equal \
        --set tolerations[0].effect=NoSchedule \
        --set tolerations[0].key=userapp \
        --set-string tolerations[0].value=true \ 
        --set tolerations[0].operator=Equal \
        --set tolerations[0].effect=NoSchedule \
        --set awsRegion=<Your-AWS-region>
Add ingress-controller to your cluster using ingress.yaml file. Use your SSL cert ARN on line number 275.

       $ kubect apply -f ingress.yaml

Add metrics server to your cluster using metrics-server.yaml file.

       $ kubectl apply -f metrics-server.yaml

Apply helm using following command:

        $  helm template . \
        --set s3.AWS_KEY=<YOUR_AWS_ACCESS_KEY> \
        --set s3.AWS_SECRET_KEY=<YOUR_AWS_SECRET_KEY> \
        --set s3.BASE_URL=<YOUR_BASE_URL> \
        --set s3.AWS_BUCKET=<Your_S3_BUCKET_NAME>  | kubectl apply -f -