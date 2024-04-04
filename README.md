# GitHub Repos Backup Script

This bash script allows you to backup all your Github repositories using your Personal Access Token.

## Prerequisites

- Set the `GITHUB_TOKEN` environment variable with your Personal Access Token (with repo scope).
- Make sure you have `curl`, `git` and `jq` installed on your system.

## How to Use

1. Clone this repository.
2. Set the `GITHUB_TOKEN` environment variable with your Personal Access Token.
3. Run the script `backup_repos.sh`.

The script will fetch the list of your repositories from GitHub, clone or update each repository to the backup
directory, and display the progress and status of each operation.

Note: The script will backup a maximum of 100 repositories.

## License

This script is released under the MIT License. Feel free to use, modify, and share it.