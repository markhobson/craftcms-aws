#!/bin/bash

docker build -t markhobson/craftcms-aws-primary .circleci/images/primary
docker login
docker push markhobson/craftcms-aws-primary
