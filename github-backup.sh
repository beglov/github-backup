#!/bin/bash

# Check if GITHUB_TOKEN is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set. Please set the variable with your Personal Access Token."
    exit 1
fi

# Set the directory where you want to store the backups
BACKUP_DIR="./repos"

# Get the list of repositories for the authenticated user
# https://docs.github.com/rest/repos/repos#list-repositories-for-the-authenticated-user
REPO_URL="https://api.github.com/user/repos?per_page=100" # max 100 results per page

REPOS=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $REPO_URL | jq '.[].ssh_url' | tr -d '"')

echo REPOS: $REPOS

# Clone or update each repository to the backup directory
for REPO in $REPOS
do
    REPO_NAME=$(echo $REPO | rev | cut -d'/' -f 1 | rev)

    if [ -d "$BACKUP_DIR/$REPO_NAME" ]; then
      echo "Update $BACKUP_DIR/$REPO_NAME repo"
      cd $BACKUP_DIR/$REPO_NAME
      git remote update --prune
      cd ../..
    else
      echo "Clone $REPO to $BACKUP_DIR/$REPO_NAME"
      git clone --mirror $REPO $BACKUP_DIR/$REPO_NAME
    fi
done

echo "Backup completed successfully!"