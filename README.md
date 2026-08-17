# ai-self-healing-devops-platform

## Kubernetes Secret Setup

Secrets are intentionally excluded from GitHub.

Create the PostgreSQL secret:

kubectl create secret generic postgres-secret `
  -n devops-app `
  --from-literal=POSTGRES_USER=postgres `
  --from-literal=POSTGRES_PASSWORD="M@yank2609"
  --from-literal=POSTGRES_DB=devops_app

Create the Flask application secret:

kubectl create secret generic app-secret `
  -n devops-app `
  --from-literal=DB_USER=postgres `
  --from-literal=DB_PASSWORD="M@yank2609"

## Kubernetes Deployment

Start Minikube:

minikube start

Apply the namespace:

kubectl apply -f k8s/namespace.yaml

Create the Kubernetes secrets using the commands documented above.

Apply the remaining manifests:

kubectl apply -f k8s/postgres-pvc.yaml
kubectl apply -f k8s/postgres-init-configmap.yaml
kubectl apply -f k8s/postgres-deployment.yaml
kubectl apply -f k8s/postgres-service.yaml
kubectl apply -f k8s/app-configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

Check the resources:

kubectl get all -n devops-app

Access the application:

minikube service flask-service -n devops-app

# Step 6.4 - CloudFormation Lifecycle

## CloudFormation Update

A stack can be updated by supplying a modified template.

Flow:

Modify template
    ↓
validate-template
    ↓
update-stack
    ↓
CloudFormation updates resources
    ↓
UPDATE_COMPLETE

## Drift

Drift occurs when live AWS resources differ from the configuration
expected from the CloudFormation template.

Command:

aws cloudformation detect-stack-drift

## Stack Events

Stack events help troubleshoot CloudFormation operations.

Command:

aws cloudformation describe-stack-events

## Stack Ownership

CloudFormation manages:

- VPC
- Subnet
- Route Table
- Internet Gateway
- Security Group
- EC2

Terraform manages separate AWS resources.

The two tools must not manage the same resource.

# Terraform

Terraform is Infrastructure as Code using a configuration language
and providers.

Important commands:

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy

## Terraform State

Terraform uses a state file to track resources managed by Terraform.

terraform.tfstate must not be committed to Git.