#!/bin/bash

# create-stack update-stack or delete-stack
COMMAND=$1 

# Name of stack: vpc-subnets | asg-alb
STACK_NAME=travel-website

# Path to template file
TEMPLATE="../cloudformation/template.yaml"


case $COMMAND in

  create)
    aws cloudformation create-stack \
    --stack-name $2 \
    --template-body file://$TEMPLATE
    ;;

  update)
    aws cloudformation update-stack \
    --stack-name $2\
    --template-body file://$TEMPLATE
    ;;

  delete)
    aws cloudformation delete-stack \
    --stack-name $2
    ;;

# Add environment variables
./env.sh