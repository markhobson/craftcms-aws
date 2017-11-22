#!/bin/bash

# Create Amazon ECR

aws ecr create-repository \
	--repository-name craftcms-aws

# Create Amazon ECS

ecs-cli up \
	--keypair admin-key-pair-london \
	--capability-iam \
	--size 1 \
	--instance-type t2.medium
