#!/bin/sh

# Build Docker image
docker build -t craftcms-demo .

# Log Docker into AWS Docker registry
$(aws ecr get-login --no-include-email)

# Push Docker image to AWS Docker registry
docker tag craftcms-demo ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/craftcms-demo
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/craftcms-demo
