#!/bin/bash

if [ "${AWS_PROFILE}" != "github-actions" ]; then
  AWS_PROFILE=secbokapp-cdk
fi

if [ "${TARGET_ENV}" = "" ]; then
  echo '[Error]'
  echo '- TARGET_ENV param required. [ local | dev | prod ]'
  echo '- ex) TARGET_ENV=local ./init/ecr_init_push.sh'
  exit 1
fi

if [ "${AWS_PROFILE}" = "github-actions" ]; then;
  CLUSTER_ARN=`aws ecs list-clusters | jq -r '.clusterArns[]' | grep ${TARGET_ENV}`
else
  CLUSTER_ARN=`aws ecs list-clusters --profile ${AWS_PROFILE} | jq -r '.clusterArns[]' | grep ${TARGET_ENV}`
fi
if [ "${CLUSTER_ARN}" = "" ]; then
  echo '[Error]'
  echo '- Cluster dose not exist'
  exit 1
fi

if [ "${AWS_PROFILE}" = "github-actions" ]; then;
  SERVICE_ARN=`aws ecs list-services --cluster ${CLUSTER_ARN} | jq -r '.serviceArns[]' | grep ${TARGET_ENV}`
else
  SERVICE_ARN=`aws ecs list-services --cluster ${CLUSTER_ARN} --profile ${AWS_PROFILE} | jq -r '.serviceArns[]' | grep ${TARGET_ENV}`
fi
if [ "${SERVICE_ARN}" = "" ]; then
  echo '[Error]'
  echo '- Service dose not exist'
  exit 1
fi

if [ "${AWS_PROFILE}" = "github-actions" ]; then;
  TASK_DEFINITION_NAME=`aws ecs list-task-definitions | jq -r '.taskDefinitionArns[]' | grep ${TARGET_ENV}`
else
  TASK_DEFINITION_NAME=`aws ecs list-task-definitions --profile ${AWS_PROFILE} | jq -r '.taskDefinitionArns[]' | grep ${TARGET_ENV}`
if
echo $TASK_DEFINITION_NAME
if [ "${TASK_DEFINITION_NAME}" = "" ]; then
  echo '[Error]'
  echo '- TaskDefinition dose not exist'
  exit 1
fi

if [ "${AWS_PROFILE}" = "github-actions" ]; then;
  aws ecs update-service \
    --cluster ${CLUSTER_ARN} \
    --service ${SERVICE_ARN} \
    --task-definition ${TASK_DEFINITION_NAME} \
    --force-new-deployment 1>/dev/null
else
  aws ecs update-service \
    --cluster ${CLUSTER_ARN} \
    --service ${SERVICE_ARN} \
    --task-definition ${TASK_DEFINITION_NAME} \
    --force-new-deployment \
    --profile ${AWS_PROFILE} 1>/dev/null
fi
