# simple-ansible-docker-lab
Lab utilizing Docker (or Podman) to spin up a lightweight lab to test Ansible

# Overview
* This lab is based on @AKI1620 | https://github.com/AKI1620/ansible-docker-lab
* Not a fan of Ubuntu, so creating my own repo to modify environment to better fit my workflow
* Containers should will be built on something like Rocky 8, or Alma 8
* This is the main branch, intended for linux machines, doesn't work on Mac

# Pre-Requisites
* Docker Desktop or Podman
* docker-podman compose plugin (if using podman, will need to install epel on rhel systems)
* ansible installed on host
  
# Usage Guide
* Not only is this a good lab, but is a nice little introduction to Docker, as the docker and compose files are pretty clear on what they're doing.
* Once the image is built, you can save it for offline usage.
* I will be using this lab in conjuction with Sander Van Vugt study material for RHCE

# File Structure
```
ansible-docker-lab/
├── build.sh
├── Dockerfile
├── docker-compose.yml
├── hosts
├── playbooks/
│   └── install-nginx.yml
├── README.md
```

# Quick Start
1. Build the image
You can altar the default credentials in the script.
```
sh build.sh
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
