FROM docker

# curl & pip

RUN apk update \
	&& apk add curl py-pip \
	&& rm -rf /var/cache/apk/*

# AWS CLI

RUN pip install awscli --upgrade --user \
	&& ln -s ~/.local/bin/aws /usr/local/bin/aws

# AWS ECS CLI

RUN curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
	&& chmod +x /usr/local/bin/ecs-cli
