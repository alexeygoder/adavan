#!/bin/bash

# --- Configuration ---
BUCKET_NAME="ada-video-storage-173479170210"
SUCCESS_FOLDER="./uploaded_successfully"
# ---------------------

# 1. Check if a filename was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE_TO_UPLOAD=$1

# 2. Check if the file actually exists
if [ ! -f "$FILE_TO_UPLOAD" ]; then
    echo "Error: File '$FILE_TO_UPLOAD' not found."
    exit 1
fi

# 3. Create the success folder if it doesn't exist
mkdir -p "$SUCCESS_FOLDER"

echo "Uploading $FILE_TO_UPLOAD to s3://$BUCKET_NAME/..."

# 4. Perform the upload
# We use 'aws s3 cp'. If you want to put it in a specific S3 folder:
# aws s3 cp "$FILE_TO_UPLOAD" "s3://$BUCKET_NAME/archive/"
aws s3 cp "$FILE_TO_UPLOAD" "s3://$BUCKET_NAME/"

# 5. Check if the previous command succeeded ($? is the exit status)
if [ $? -eq 0 ]; then
    echo "Upload successful! Moving file to $SUCCESS_FOLDER"
    mv -n "$FILE_TO_UPLOAD" "$SUCCESS_FOLDER/"
else
    echo "Upload failed. File remains in original location."
    exit 1
fi