# ansible-docker-lab
Lab utilizing Docker (or Podman) to spin up a lightweight lab to test Ansible

# Overview
* This lab is based on @AKI1620 | https://github.com/AKI1620/ansible-docker-lab
* Not a fan of Ubuntu, so creating my own repo to modify environment factors more closely to my workflow
* Containers should will be built on something like Rocky 8, or Alma 8

# Usage Guide
* Not only is this a good lab, but is a nice little introduction to Docker, as the docker and compose files are pretty clear on what they're doing.
* Once the image is built, you can save it for offline usage.

# File Structure
```
ansible-docker-lab/
├── build.sh
├── Dockerfile
├── docker-compose.yml
├── inventory.ini
├── playbooks/
│   └── install-nginx.yml
├── README.md
```

# Quick Start
1. Build the image
```
docker build --no-cache -t rockyssh:8.0
```
2. Start the test nodes
```
docker-compose up -d
```
3. Verify SSH connectivity
```
ssh appuser@10.20.0.10
# password: Admin@123
```
4. Run a playbook
```
ansible-playbook -i inventory.ini playbooks/install-nginx.yml
```
5. Tear down
```
docker compose down
```

# Default Credentials
```
Username: appuser
Password: Admin@123
Privilege: sudo enabled
```
