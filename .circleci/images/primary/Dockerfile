FROM docker

# curl, pip & npm

RUN apk update \
	&& apk add curl py-pip nodejs-npm \
	&& rm -rf /var/cache/apk/*

# AWS CLI

RUN pip install awscli --upgrade --user \
	&& ln -s ~/.local/bin/aws /usr/local/bin/aws
