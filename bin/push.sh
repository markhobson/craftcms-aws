#!/bin/bash

echo "Build public assets"
npm install
npm run dist

echo "Build Docker image"
docker build -t craftcms-aws .

echo "Log Docker into AWS ECR"
$(aws ecr get-login --no-include-email)

echo "Push Docker image to AWS ECR"
docker tag craftcms-aws ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/craftcms-aws
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/craftcms-aws

echo "Update AWS stack"
aws cloudformation update-stack --stack-name craftcms-aws --template-body file://service.yml --capabilities CAPABILITY_IAM
