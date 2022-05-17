#!/bin/bash

# create-stack update-stack or delete-stack
COMMAND=$1 

# Name of stack: vpc-subnets | asg-alb
export STACK_NAME=travel-website

# Path to template file
TEMPLATE="../cloudformation/template.yaml"


case $COMMAND in

  create)
    aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://$TEMPLATE

    # Add environment variables and run other commands
    ./env.sh
    aws s3 cp ../web-files s3://$BUCKET
    ;;

  update)
    aws cloudformation update-stack \
    --stack-name $STACK_NAME\
    --template-body file://$TEMPLATE

    # Add environment variables and run other commands
    ./env.sh
    ;;

  delete)
    #empty s3 bucket
    aws s3 rm s3://$BUCKET_NAME --recursive

    aws cloudformation delete-stack \
    --stack-name $STACK_NAME
    ;;

