# Craft CMS on AWS

This project shows how to run [Craft CMS](https://craftcms.com/) on [Amazon Web Services](https://aws.amazon.com/). It is deployed as [Docker](https://www.docker.com/) images to [Amazon ECS](https://aws.amazon.com/ecs/) using [CircleCI](https://circleci.com/) for continuous integration. The build pipeline uses [npm](https://www.npmjs.com/) to generate the site's CSS from customisable [Bootstrap](http://getbootstrap.com/) SCSS.

## Getting started

Follow these steps to create a Craft CMS site on AWS.

### 1. Create your project

Start by creating your own project:

1. [Fork](https://help.github.com/articles/fork-a-repo/) this project to your own GitHub account
2. Clone your repository locally

### 2. Configure AWS

We'll use Amazon Web Services to host your site.

1. Create an [Amazon Web Services](https://aws.amazon.com/) account if you haven't already got one
1. Create `admin` user
1. Create SSH key `admin-key-pair-london`
1. Create `ci` user
1. Create `ci` group with policies:
	* `AmazonEC2ContainerRegistryPowerUser`
	* `AmazonEC2ContainerServiceFullAccess` (?)
1. Decide on an AWS region, e.g. `eu-west-2`

### 3. Configure CircleCI

We'll use CircleCI for continuous integration.

1. Sign up to [CircleCI](https://circleci.com/) with your GitHub account if you haven't already done so
1. Add your forked project
1. Add the following environment variables to the project with your `ci` user credentials and chosen region:
	* `AWS_ACCOUNT_ID`
	* `AWS_ACCESS_KEY_ID`
	* `AWS_SECRET_ACCESS_KEY`
	* `AWS_DEFAULT_REGION`

### 4. Install AWS CLI

We'll use the Amazon CLI tools to bring up the necessary infrastructure.

1. [Install AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
1. [Configure AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) using your `admin` user credentials and chosen region
1. [Install Amazon ECS CLI](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html)
1. [Configure Amazon ECS CLI](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_Configuration.html) using your `admin` user credentials and chosen region:

```sh
ecs-cli configure profile --profile-name default --access-key ${AWS_ACCESS_KEY_ID} --secret-key ${AWS_SECRET_ACCESS_KEY}
ecs-cli configure --cluster craftcms-aws --region ${AWS_DEFAULT_REGION} --config-name default
```

### 5. Create AWS infrastructure

To create your Amazon ECR and ECS services:

```sh
./bin/aws-up.sh
```

Note that you'll be charged for these services until they are [destroyed](#destroy-aws-infrastructure).

### 6. Deploy site

Push a change and CircleCI will deploy the site to AWS. Once the job is complete find the site's IP address using:

```sh
ecs-cli ps
```

Visit `http://<ip-address>/admin` to run the [Craft CMS installer](https://craftcms.com/docs/installing#step-5-run-the-installer). Once complete, visit `http://<ip-address>` to view your site.

## Running locally

You can run the site locally as follows:

1. `npm install`
1. `npm run dist`
1. `docker-compose up --build`
1. Visit http://localhost/admin

To watch SCSS:

```sh
npm run watch
```

## Destroy AWS infrastructure

To destroy the services:

```sh
./bin/aws-down.sh
```

## TODO

* Style news templates
* Automate CircleCI primary image build in DockerHub
* Ensure database is private
* Prod/dev environments
* Fargate
* CloudFormation
* RDS
* DNS
* SSL
