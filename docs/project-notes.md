# Phase 2 - Flask + PostgreSQL

## Flask

Flask is the web framework used to build the application.

## PostgreSQL

PostgreSQL is the relational database used to store application data.

## psycopg2

psycopg2 allows Python to communicate with PostgreSQL.

## Application Flow

Browser
    ↓
Flask
    ↓
database.py
    ↓
PostgreSQL
    ↓
users table

## Environment Variables

Database credentials are stored in environment variables instead
of hardcoded in application code.

## .env

.env is used for local development and must not be committed
to GitHub because it contains sensitive credentials.

## Health Endpoint

/health returns the application health status.

This endpoint will later be used by Kubernetes health probes.

## Current Application

The application retrieves name, age and email from PostgreSQL
and displays them through an HTML page.
# Phase 3 - Docker

## Docker Image

A Docker image is a packaged template containing the application,
runtime and dependencies.

## Docker Container

A container is a running instance of an image.

## Dockerfile

Dockerfile contains instructions used to build the Docker image.

## Docker Build

Command:

docker build -f docker/Dockerfile -t ai-devops-app:v1 .

## Docker Run

The container exposes port 5000.

Port mapping:

Windows:5000 -> Container:5000

## Environment Variables

Database configuration is supplied when the container starts.

The database password is not hardcoded into the Dockerfile.

## Docker Networking

localhost inside a container refers to the container itself.

host.docker.internal is used by Docker Desktop to access services
running on the host machine.

## Current Architecture

Browser
    ↓
Docker Container
    ↓
Flask
    ↓
host.docker.internal
    ↓
PostgreSQL on Windows
# Phase 4 - Kubernetes

## Namespace

A Namespace logically isolates resources inside a Kubernetes cluster.

Project namespace:

devops-app

## Deployment

Deployment manages the desired number of application Pods.

Flask Deployment:
2 replicas

## Pod

Pod is the smallest deployable unit in Kubernetes.

The Flask application runs inside a Pod.

## Service

A Service provides a stable network endpoint for Pods.

Flask:
NodePort

PostgreSQL:
ClusterIP

## ConfigMap

ConfigMap stores non-sensitive configuration.

Example:

DB_HOST=postgres-service

## Secret

Secret stores sensitive configuration such as database credentials.

## PersistentVolumeClaim

PVC requests persistent storage for PostgreSQL.

This prevents database data from depending only on the Pod filesystem.

## Kubernetes DNS

Flask connects to PostgreSQL through:

postgres-service

rather than a Pod IP.

## Probes

Readiness probe:

Determines whether a Pod should receive traffic.

Liveness probe:

Determines whether Kubernetes should restart a failed container.

## Desired State

Deployment declares:

replicas: 2

Kubernetes continuously attempts to maintain the desired state.

## Self-Healing

If a Flask Pod is deleted or crashes, the Deployment creates a replacement Pod.
# Phase 5 - Argo CD and GitOps

## Argo CD

Argo CD is a declarative GitOps continuous delivery tool for Kubernetes.

## GitOps

Git is used as the source of truth for the desired Kubernetes state.

Architecture:

Developer
    ↓
GitHub
    ↓
Argo CD
    ↓
Kubernetes

## Argo CD Application

An Application defines:

- Git repository
- Git revision
- Repository path
- Kubernetes destination
- Sync policy

## Automated Sync

Argo CD automatically synchronizes changes from Git to Kubernetes.

## Pruning

Pruning removes resources from the cluster when they are removed
from the desired Git state.

## Self-Healing

Self-healing detects manual changes to the cluster and reconciles
the cluster back to the desired state in Git.

## Drift

Drift occurs when live Kubernetes state differs from the desired
state stored in Git.

Example:

Git:
replicas = 3

Cluster:
replicas = 1

Argo CD detects the difference and self-heals the application.

## CI vs CD

GitHub Actions:
Continuous Integration

Argo CD:
GitOps-based Continuous Delivery
# Phase 6 - AWS and Infrastructure as Code

## AWS Region

Project region:

ap-south-1

## VPC

A VPC is the isolated virtual network for AWS resources.

## Subnet

A subnet is a network segment inside a VPC.

## Security Group

A security group acts as a virtual firewall controlling network traffic
to AWS resources.

## EC2

EC2 provides virtual compute instances in AWS.

## CloudFormation

CloudFormation is AWS-native Infrastructure as Code.

A CloudFormation template defines AWS resources.

A stack is the deployed collection of resources defined by a template.

## Terraform

Terraform is Infrastructure as Code using providers to manage resources.

## IaC Ownership

CloudFormation and Terraform will not manage the same AWS resources.

CloudFormation will manage the initial AWS networking and EC2 infrastructure.

Terraform will manage additional AWS resources separately.