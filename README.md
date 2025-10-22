# simple-ansible-docker-lab
Lab utilizing Docker (or Podman) to spin up a lab to test Ansible

# Overview
* This is an isolated Ansible lab that can run indenpendent from your network
* Compose file builds two images, one for a control node, one for managed node
* Compose file creates a single control node, and three managed.
* Control node binds two directories to the working environment called "ansible-data" and "ansible-collections"

# Pre-Requisites
* 2GB of free space
* Docker Desktop or Podman
* docker-podman compose plugin (if using podman)

# Usage Guide
* I mainly built this to work with Mac
* I recommend using podman and podman-compose with the main branch on linux (or WSL)
* My goal with this project was to create a easy method to spin up a virtual environment without the need of server maintenance.
* Ansible data should be persistent, meaning any work you do, will stay. If you want a completely fresh start, wipe "ansible-data"

# File Structure

```
ansible-lab/
├─ compose.yml
├─ .env
├─ images/
│  ├─ control/
│  │  └─ Dockerfile
│  └─ node/
│     └─ Dockerfile
├─ ansible-data/
│  ├─ ansible.cfg
│  ├─ hosts
│  ├─ group_vars/
│  ├─ host_vars/
│  ├─ roles/
│  ├─ playbooks/
│  └─ .vault_pass.txt
└─ ansible-collections/
```

# Quick Start
1. Start the environment
```
docker compose build
docker compose up -d
docker exec -it ansible bash
```
2. Shell into the ansible node
```
docker exec -it ansible bash
```

3. Run a command
```
ansible -m ping testnodes
```

# Things to change
* How the images are built
* Entry points
* Import user ssh key (or create one that can be imported)
