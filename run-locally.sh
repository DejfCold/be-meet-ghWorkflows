#!/bin/bash

set -ex

# Path to the .api_key file
API_KEY_FILE=".api_key"

# Check if the .api_key file exists
if [ -f "$API_KEY_FILE" ]; then
    # Read the content of the file, trimming any newline at the end
    API_KEY=$(<"$API_KEY_FILE")
else
    # Set default value if the file does not exist
    API_KEY="secret_api_key"
fi

### install for fedora (for others: https://nektosact.com/installation/index.html)
# sudo dnf copr enable goncalossilva/act
# sudo dnf install act-cli

# run basic workflow
# act --workflows .github/workflows/basic.yaml

# run failing workflow
# act --workflows .github/workflows/fail.yaml

# run failing workflow
act \
  --secret GITHUB_TOKEN=${API_KEY} \ # replace with your github api key
  --var VERSION_TYPE=patch \
  --workflows .github/workflows/release.yaml

