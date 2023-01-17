# cloudifytests Infrastructure


## Prerequisite
**kubectl –** A command line tool for working with Kubernetes clusters.

**eksctl –** A command line tool for working with EKS clusters that automates many individual tasks.

**Required AWS IAM permissions –** The IAM security principal that you're using must have permissions to work with Amazon EKS IAM roles and service linked roles, AWS CloudFormation, and a VPC and related resources.

## Steps to add infrastructure to your local

Git clone the project:

       $ git clone https://github.com/Roshanitft/cloudifytests.git
 
Create a Namespace (namespace name is uesd as $org_name)

Apply helm using following command:

        $  helm template . \
        --set s3microservices.AWS_KEY=<YOUR_AWS_ACCESS_KEY> \
        --set s3microservices.AWS_SECRET_KEY=<YOUR_AWS_SECRET_KEY> \
        --set urls.BASE_URL=https://$org_name.cloudifytests.io \
        --set s3microservices.AWS_BUCKET=<Your_S3_BUCKET_NAME>  \
        --set s3microservices.AWS_DEFAULT_REGION="<Your_AWS_REGION_NAME>"
        --set ingress.hosts[0]=$ingress_host \
        --set sessionbe.serviceAccountName=$org_name --set nginxhpa.metadata.namespace=$org_name \
        --set be.ORG_NAMESPACE=$org_name \
        --set sessionbe.image.repository="975876589297.dkr.ecr.us-east-1.amazonaws.com/cloudifytest_be:stg" \
        --set sessionUi.image.repository="975876589297.dkr.ecr.us-east-1.amazonaws.com/cloudifytests_fe" --set sessionUi.image.tag="tunnel_fe" \
        --set smcreate.image.repository="975876589297.dkr.ecr.us-east-1.amazonaws.com/sm_create:stg"  \
        --set smdelete.image.repository="975876589297.dkr.ecr.us-east-1.amazonaws.com/sm_delete:stg" \
        --set sessionmanager.AWS_ECR_IMAGE="975876589297.dkr.ecr.us-east-1.amazonaws.com"   \
        --set smlogsvalues.ORG_NAME=$org_name \
        --set behpa.metadata.namespace=$org_name --set sessionManagaerhpa.metadata.namespace=$org_name \
        --set role.metadata.namespace=$org_name --set roleBinding.metadata.namespace=$org_name \
        --set smcreatehpa.metadata.namespace=$org_name --set smdeletehpa.metadata.namespace=$org_name \
        --set serviceaccount.metadata.namespace=$orgname --set roleBinding.subjects.namespace=$orgname | kubectl create --namespace $org_name -f -
        
