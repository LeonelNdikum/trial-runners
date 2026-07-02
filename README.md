# Zsoftly Team — Project 2: Dockerized Static Website

> A static HTML/CSS website containerised with Docker, served by Nginx, and published to a container registry.

---

## Project Structure

```
zsoftly/
├── website/
│   ├── index.html    ← the website
│   └── style.css     ← the styles
├── Dockerfile        ← packages everything into a Docker image
├── nginx.conf        ← custom Nginx server configuration
└── README.md         ← this file
```

---

## Team

| Name | Role | Responsibility |
|------|------|----------------|
| **Ketsy Kemajou** | Team Lead | Coordinate the team, manage issues, ensure on-time delivery |
| **Leonel Ndikum** | Docker Engineer | Write and test the Dockerfile, build the image, run locally |
| **Collins** | GitHub Workflow Engineer | Manage branches, PRs, issue tracking, and release notes |
| **Joy** | Documentation Engineer | Write README, setup guide, and usage instructions |
| **Hansley** | QA Reviewer | Test the website, verify Docker commands, review PRs |
| **Kenny** | Support Engineer | Help with testing, troubleshooting, registry push/pull |

------

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) v20.10+
- [Git](https://git-scm.com/)
- A [Docker Hub](https://hub.docker.com/) account (for publishing)

```bash
# Verify Docker is installed and running
docker --version
docker info
```

---

## Quick Start

```bash
# 1. Clone the repository
git clone git@github.com:kemajouketsy/Dockerized-static-website-project.git

# 2. Build the Docker image
docker build -t static-website .

# 3. Run the container
docker run -d -p 8080:80 --name static-website static-website

# 4. Open in your browser → http://localhost:8080
```

---

## Build the Image

```bash
docker build -t static-website .
```

| Flag | Meaning |
|------|---------|
| `-t static-website` | Names the image `static-website` |
| `.` | Uses the current directory as the build context |

---

## Run the Container

```bash
docker run -d -p 8080:80 --name static-website static-website
```

| Flag | Meaning |
|------|---------|
| `-d` | Detached (background) mode |
| `-p 8080:80` | Maps host port **8080** → container port **80** |
| `--name static-website` | Names the container `static-website` |

Visit **http://localhost:8080** to view the site.

---

## Push to Docker Hub

```bash
# Log in
docker login

# Tag with your Docker Hub username
docker tag static-website YOUR_USERNAME/static-website:v1.0

# Push
docker push YOUR_USERNAME/static-website:v1.0
```

## Pull & Run from Registry

```bash
docker pull YOUR_USERNAME/static-website:v1.0
docker run -d -p 8080:80 --name static-website YOUR_USERNAME/static-website:v1.0
```

---

## Useful Docker Commands

```bash
# List running containers
docker ps

# View container logs
docker logs static-website

# Open a shell inside the container
docker exec -it static-website sh

# Stop the container
docker stop static-website

# Remove the container
docker rm static-website

# Remove the image
docker rmi static-website

# Stop and remove in one step
docker stop static-website && docker rm static-website

# Remove all unused resources
docker system prune
```

---

## Contributing

```bash
# 1. Create a feature branch
git checkout -b feature/your-feature-name

# 2. Commit your changes
git add .
git commit -m "feat: describe your change"

# 3. Push and open a Pull Request against main
git push origin feature/your-feature-name
```

Request a review from **Hansley** (QA Reviewer). All PRs require approval before merge.

### Commit convention

| Prefix  | Use for |
|-------- |---------|
| `feat:` | New feature |
| `fix:`  | Bug fix |
| `docs:` | Documentation only |
| `chore:` | Maintenance / config |
| `style:` | Formatting, no logic change |

---

## Deliverables Checklist

| # | Deliverable | Owner | Status |
|---|-------------|-------|--------|
| 1 | Static website files (`index.html`, `style.css`) | Leonel | ✅ |
| 2 | Working `Dockerfile` | Leonel | ✅ |
| 3 | Docker image running locally (`static-website`) | Leonel | ✅ |
| 4 | Published image on Docker Hub / GHCR | Kenny | ⬜ |
| 5 | Setup guide & README | Joy | ✅ |
| 6 | PR history with reviews & approvals | Collins / Hansley | ⬜ |

---

*Zsoftly Team · Project 2 · 2025 · Team Lead: Ketsy Kemajou*
