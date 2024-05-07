#!/bin/bash

# The file containing the version
FILE="version.txt"

# Check if the version file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE does not exist."
    exit 1
fi

# Read the version from the file
version=$(cat "$FILE")
IFS='.' read -r -a parts <<< "$version"

# Major, minor, and patch versions
major="${parts[0]}"
minor="${parts[1]}"
patch="${parts[2]}"

# Function to increment the version
increment_version() {
    case $1 in
        --major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        --minor)
            minor=$((minor + 1))
            patch=0
            ;;
        --patch)
            patch=$((patch + 1))
            ;;
        *)
            echo "Usage: $0 [--major|--minor|--patch]"
            exit 1
            ;;
    esac

    # Save the new version back to the file
    echo "${major}.${minor}.${patch}" > "$FILE"
}

# Check for arguments and increment accordingly
if [ $# -eq 0 ]; then
    echo "No arguments provided."
    echo "Usage: $0 [--major|--minor|--patch]"
    exit 1
else
    increment_version "$1"
fi
