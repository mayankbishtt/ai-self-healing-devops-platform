# Security Exceptions

## AWS-0104 — Unrestricted outbound HTTPS

The EC2 instance is intentionally allowed to make outbound HTTPS
connections to the internet.

Reason:
- Amazon Linux package updates
- GitHub access
- GitHub Container Registry access
- Docker image pulls
- DevOps tooling downloads

The project is a learning environment and the EC2 instance requires
internet access for these operations.

## AWS-0164 — Public IP on subnet

The EC2 instance is intentionally deployed in a public subnet with
public IP assignment.

Reason:
- Demonstrate public subnet architecture
- Demonstrate Internet Gateway routing
- Demonstrate SSH access to EC2
- Demonstrate Docker/Git operations on the EC2

Production architecture would normally use tighter network isolation
and a private management path such as AWS Systems Manager where
appropriate.