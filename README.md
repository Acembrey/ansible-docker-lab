# simple-ansible-docker-lab
Lab utilizing Docker (or Podman) to spin up a lightweight lab to test Ansible

# Overview
* This branch contains some seperate configurations for mac
* I'll have to update this readme later, basically just creates a ansible control node, and three managed nodes.
* I'd like to clean this up a lot, images are built off of what I could find scraping the internet rather than research. 
* I wouldn't really consider this to be a lightweight lab.

# Pre-Requisites
* Docker Desktop or Podman
* docker-podman compose plugin (if using podman, will need to install epel on rhel systems)
* ansible installed on host

# Usage Guide
* This ended up being more work than I thought
* I recommend using podman and podman-compose with the main branch on linux (or WSL)
* With the above being said, this is an isolated environment, and semi modular.

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
2. Ping the servers
```
ansible -m ping testnodes
```
