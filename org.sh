#!/bin/bash
# A Bash script to create namespace

path=$1
org_name=$2
aws_key=$3
aws_secret_key=$4
aws_region=$5
base_url=$6
ingress_host=$7
cluster_name=$8

aws eks --region $aws_region  update-kubeconfig --name $cluster_name

kubectl create ns $org_name
helm template $path --set urls.BASE_URL=$base_url \
--set ingress.hosts[0]=$ingress_host \
--set s3microservices.AWS_ACCESS_KEY_ID=$aws_key --set s3microservices.AWS_SECRET_ACCESS_KEY=$aws_secret_key \
--set sessionbe.serviceAccountName=$org_name --set nginxhpa.metadata.namespace=$org_name \
--set be.ORG_NAMESPACE=$org_name \
--set smlogsvalues.ORG_NAME=$org_name \
--set behpa.metadata.namespace=$org_name --set sessionManagaerhpa.metadata.namespace=$org_name \
--set role.metadata.namespace=$org_name --set roleBinding.metadata.namespace=$org_name \
--set smcreatehpa.metadata.namespace=$org_name --set smdeletehpa.metadata.namespace=$org_name \
--set serviceaccount.metadata.namespace=$orgname --set roleBinding.subjects.namespace=$orgname | kubectl create --namespace $org_name -f -

