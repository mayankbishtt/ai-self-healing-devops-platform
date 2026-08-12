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