#!/bin/bash

####################
#Date: 08-Aug-2025
#Version: V1
#Author: Shubham Prasar
#Notes: Simple Bash script to list users with **read (pull)** access to a specific GitHub repository using the GitHub REST API.
####################


# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token (expected to be passed as environment variables)
USERNAME="$username"
TOKEN="$token"

# User and Repository Information (these are positional arguments)
REPO_OWNER=$1
REPO_NAME=$2

function helper {
    num_of_parameter=2
    if [[ $# -ne 2 ]]; then
        echo "Error: You must provide exactly 2 arguments: <repo_owner> <repo_name>"
        exit 1
    fi    
}

# Function to make a GET request to the GitHub API 
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main Script Execution
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
