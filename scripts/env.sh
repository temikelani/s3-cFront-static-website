#!/bin/bash

aws cloudformation describe-stacks --stack-name $STACK_NAME

aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs"

export BUCKET_NAME=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[0].OutputValue" --output text)

export CDN_ID=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[1].OutputValue" --output text)

export BUCKET_URL=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[2].OutputValue" --output text)

export CDN_DOMAIN=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[3].OutputValue" --output text)

aws s3 cp ../web-files s3://$BUCKET