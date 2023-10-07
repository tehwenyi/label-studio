#!/bin/bash

# Set the path to the parent directory of the image directory.
# Important: It cannot be the image directory itself; it must be the parent directory.
PATH_TO_PARENT_DIRECTORY=/path/to/dataset/directory

# Set the maximum number of files that can be uploaded to Label Studio.
DATA_UPLOAD_MAX_NUMBER_FILES=1000

# Run a Docker container with Label Studio.
docker run -it -p 8080:8080 \
    -v $(pwd)/mydata:/label-studio/data \
    -v $PATH_TO_PARENT_DIRECTORY:/label-studio/files \  # Mount the specified parent directory to /label-studio/files in the container.
    -e DATA_UPLOAD_MAX_NUMBER_FILES=$DATA_UPLOAD_MAX_NUMBER_FILES \  # Set an environment variable for the maximum upload limit.
    -e LOCAL_FILES_SERVING_ENABLED=1 \  # Enable serving of local files inside the container.
    -e LOCAL_FILES_DOCUMENT_ROOT=/label-studio/files \  # Set the document root for serving local files.
    heartexlabs/label-studio:latest label-studio \
    --log-level DEBUG
