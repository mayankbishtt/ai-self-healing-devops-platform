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
