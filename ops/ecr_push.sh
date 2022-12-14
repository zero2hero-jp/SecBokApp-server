#!/bin/bash

AWS_PROFILE=secbokapp-cdk
AWS_REGION=ap-northeast-1
AWS_ACCOUNT_ID=`aws sts get-caller-identity --profile ${AWS_PROFILE} --query 'Account' --output text`

if [ "${TARGET_ENV}" = "" ]; then
  echo '[Error]'
  echo '- TARGET_ENV param required. [ local | dev | prod ]'
  echo '- ex) TARGET_ENV=local ./ops/ecr_init_push.sh'
  exit 1
fi
REPO_NAME=ecr-${TARGET_ENV}

if [ "${AWS_ACCOUNT_ID}" = "" ]; then
  echo '[Error]'
  echo '- aws_resion or asw_account_id settings not found.'
  echo '- Please check your .evn.development file.'
  exit 1
fi

IMAGE_ID=`docker images | grep secbokapp-server | awk '{print $3}'`
if [ "${IMAGE_ID}" = "" ]; then
  echo '[Error]'
  echo '- docker image not found.'
  echo '- Please check docker images. Does secbokapp-server image exist?'
  exit 1
fi

# ECRに対してDockerクライアント認証をする。
aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE} | 
  docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# リポジトリのURIを取得
REPO_URI=`aws ecr describe-repositories --profile ${AWS_PROFILE} | 
  jq -r '.repositories[].repositoryUri' | 
  grep ${REPO_NAME}`

if [ "${REPO_URI}" = "" ]; then
  echo '[Error]'
  echo '- ECR repository does not exist.'
  echo "- Please make sure that your repository has ${REPO_NAME}"
  exit 1
fi

# build & タグ付け
DOCKER_BUILDKIT=1 docker build . -t ${REPO_URI}:latest

# イメージをERCRにpush
docker push ${REPO_URI}:latest
