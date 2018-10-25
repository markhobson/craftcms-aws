#!/bin/bash

aws cloudformation create-stack --stack-name craftcms-aws --template-body file://stack.yml --capabilities CAPABILITY_IAM
