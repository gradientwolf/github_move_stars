#!/bin/bash

# Path to the file containing the list of repositories
REPO_FILE="oppy_starred.txt"

# Check if the file exists
if [[ ! -f "$REPO_FILE" ]]; then
  echo "File $REPO_FILE not found!"
  exit 1
fi

# Read the file line by line and star each repository
while IFS= read -r repo; do
  echo "Processing repository: $repo"

  # Use gh api to star the repository
  echo "Sending request to star $repo..."
  response=$(gh api -X PUT "/user/starred/$repo" --silent --include 2>&1)
  status_code=$(echo "$response" | awk '/HTTP/{print $2}')

  # Check if the request was successful
  if [[ "$status_code" == "204" ]]; then
    echo "Successfully starred $repo"
  else
    echo "Failed to star $repo. Status code: $status_code"
    echo "Response: $response"
  fi

  # Add a 3-second delay between requests
  echo "Waiting 3 seconds before the next request..."
  sleep 3
done < "$REPO_FILE"
