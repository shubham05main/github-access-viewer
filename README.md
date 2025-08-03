# GitHub Repository Read Access Checker

This is a Bash script that uses the GitHub API to list users who have **read access** to a specified repository. It's useful for auditing collaborators on GitHub projects.

---

## 🧰 Features

- Connects to the GitHub API using a personal access token (PAT)
- Lists all users with **read (`pull`) access** to a repository
- Supports both personal and organizational repositories
- Works directly from the command line or a server (like AWS EC2)

---

## 📋 Requirements

- Bash (default on most Linux systems)
- `curl` for making HTTP requests
- `jq` for parsing JSON
- GitHub Personal Access Token (PAT)

To install `jq` on EC2:

```bash
# For Amazon Linux
sudo yum install jq

# For Ubuntu/Debian
sudo apt install jq
