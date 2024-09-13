#!/usr/bin/env bash

OUTPUT_DIRECTORY="output"

# Get first build directory
BUILD_NAME=$(find . -maxdepth 1 -type d ! -name '.*' | xargs -I {} basename {})

# Searching for valid build directory
BUILD_DIRECTORY=""
for directory in ${BUILD_NAME}; do
  if [[ "${directory}" =~ ^[0-9]{2}\.[0-9]{8}\.[a-z]{3,4}\.[0-9]{1}$ ]]; then
    BUILD_DIRECTORY="${directory}"
  fi
done

# Check if build directory is valid
if [[ -z "${BUILD_DIRECTORY}" ]]; then
  echo "No valid build directory found!"
  exit 1
else
  echo "Build directory found: ${BUILD_DIRECTORY}"
fi

# Create output directory
if [[ ! -d "${OUTPUT_DIRECTORY}" ]]; then
  echo "Creating output directory ${OUTPUT_DIRECTORY}"
  mkdir -p ${OUTPUT_DIRECTORY}
fi

# Process files
for file in $(find ${BUILD_DIRECTORY} -type f); do
  # Get file extension
  FILE_EXTENSION="${file##*.}"

  # Get file name without extension
  FILE_NAME=$(basename "${file}")

  # Get file directory
  FILE_DIRECTORY=$(dirname "${file}")

  # Get architecture
  ARCHITECTURE=$(echo ${FILE_DIRECTORY} | cut -d/ -f 2)

  # Skip unnecessary files
  if [[ "${FILE_EXTENSION}" =~ ^(json|ociarchive)$ ]]; then
    echo "Skipping unnecessary file ${FILE_NAME}"
    continue
  fi

  # Create architecture directory
  if [[ ! -d "${OUTPUT_DIRECTORY}/${ARCHITECTURE}" ]]; then
    echo "Creating architecture directory ${OUTPUT_DIRECTORY}/${ARCHITECTURE}"
    mkdir -p ${OUTPUT_DIRECTORY}/${ARCHITECTURE}
  fi

  if [[ "${FILE_NAME}" =~ fedora-coreos- ]]; then
    NEW_FILE_BASE=$(echo ${FILE_NAME} | sed -E "s/fedora-coreos-${BUILD_DIRECTORY}-//g" | cut -d"." -f 1)
    NEW_FILE_NAME="${NEW_FILE_BASE}.${FILE_EXTENSION}"
    echo "Copying ${file} to ${OUTPUT_DIRECTORY}/${ARCHITECTURE}/${NEW_FILE_NAME}"
    mv ${file} ${OUTPUT_DIRECTORY}/${ARCHITECTURE}/${NEW_FILE_NAME}
  fi
done

# Clean up old build directory
echo "Removing old build directory ${BUILD_DIRECTORY}"
rm -rf "${BUILD_DIRECTORY}"
