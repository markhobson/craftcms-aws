#!/bin/bash

# Destroy Amazon ECS

ecs-cli down \
	--force

# Destroy Amazon ECR

aws ecr delete-repository \
	--repository-name craftcms-demo \
	--force
