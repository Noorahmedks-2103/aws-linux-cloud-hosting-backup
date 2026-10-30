#!/bin/bash

set -Eeuo pipefail

PROJECT_DIR="$HOME/aws-linux-cloud-project"
BACKUP_DIR="/tmp/aws-cloud-backups"
S3_BUCKET="noor-aws-cloud-backup-2026-565393656907"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="cloud-project-backup-${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Creating full project backup..."

tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
    -C "$PROJECT_DIR" \
    --exclude='.git' \
    website scripts docs iam README.md .gitignore

echo "Checking archive integrity..."

tar -tzf "$BACKUP_DIR/$BACKUP_FILE" > /dev/null

echo "Uploading backup to S3..."

aws s3 cp \
    "$BACKUP_DIR/$BACKUP_FILE" \
    "s3://$S3_BUCKET/backups/$BACKUP_FILE"

echo "Backup completed successfully!"
