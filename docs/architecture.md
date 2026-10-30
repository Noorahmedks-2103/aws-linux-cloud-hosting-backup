# AWS Cloud Infrastructure Architecture

## Architecture Overview

Internet
   |
   v
Internet Gateway
   |
   v
AWS VPC (172.31.0.0/16)
   |
   v
Public Subnet (172.31.0.0/20)
   |
   v
EC2 Ubuntu Instance
   |
   +---- Nginx Web Server
   |
   +---- Bash Backup Script
              |
              v
         AWS CLI
              |
         IAM Instance Role
              |
              v
         Amazon S3
              |
         Backup Archives

## Backup Workflow

1. Bash script collects project files.
2. Tar compresses the project.
3. Archive integrity is checked.
4. AWS CLI uploads the archive to S3.
5. Cron schedules recurring backups.

## Recovery Workflow

1. Download archive from S3.
2. Extract archive.
3. Verify recovered project files.
