#!/bin/bash

# Get instance ID from metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Get attached volume ID
VOLUME_ID=$(aws ec2 describe-volumes \
  --filters Name=attachment.instance-id,Values=$INSTANCE_ID \
  --query "Volumes[*].VolumeId" \
  --output text)

# Create snapshot with description
SNAPSHOT_ID=$(aws ec2 create-snapshot \
  --volume-id $VOLUME_ID \
  --description "Automated snapshot from instance $INSTANCE_ID" \
  --query "SnapshotId" \
  --output text)

# Output result
echo "Snapshot created: $SNAPSHOT_ID"

# (Optional) Send SNS alert
# aws sns publish \
#   --topic-arn arn:aws:sns:us-east-1:123456789012:devops-alerts \
#   --message "Snapshot created: $SNAPSHOT_ID"

