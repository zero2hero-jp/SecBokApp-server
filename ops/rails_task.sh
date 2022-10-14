#!/bin/bash

AWS_PROFILE=secbokapp-cdk

if [ "${TARGET_ENV}" = "" ]; then
  echo '[Error]'
  echo '- TARGET_ENV param required. [ local | dev | prod ]'
  echo '- ex) TARGET_ENV=local ./ops/rails_task.sh db:migrate'
  exit 1
fi

COMMAND=$@
if [ "${COMMAND}" = "" ]; then
  echo '[Error]'
  echo '- command was null'
  echo '- ex) TARGET_ENV=local ./ops/rails_task.sh db:migrate'
  exit 1
fi

OVERRIDE_FILE=./overrides.json

FAMILY_NAME=task-${TARGET_ENV}

CLUSTER_ARN=`aws ecs list-clusters --profile ${AWS_PROFILE} | jq -r '.clusterArns[]' | grep ${TARGET_ENV}`
if [ "${CLUSTER_ARN}" = "" ]; then
  echo '[Error]'
  echo '- Cluster dose not exist'
  exit 1
fi

SERVICE_ARN=`aws ecs list-services --cluster ${CLUSTER_ARN} --profile ${AWS_PROFILE} | jq -r '.serviceArns[0]'`
if [ "${SERVICE_ARN}" = "" ]; then
  echo '[Error]'
  echo '- Cluster dose not exist'
  exit 1
fi

TASK_DEF_ARN=$(aws ecs list-task-definitions \
  --family-prefix "${FAMILY_NAME}" \
  --query "reverse(taskDefinitionArns)[0]" \
  --profile ${AWS_PROFILE} \
  --output text) \

CONTAINER_NAME=$(aws ecs describe-task-definition \
  --task-definition "${TASK_DEF_ARN}" \
  --query "taskDefinition.containerDefinitions[0].name" \
  --profile ${AWS_PROFILE} \
  --output text)  \
&& cat <<EOF > overrides.json
  {
    "containerOverrides": [
      {
        "name": "${CONTAINER_NAME}",
        "command": ["rails", "${COMMAND}"]
      }
    ]
  }
EOF

NETWORK_CONFIG=$(aws ecs describe-services \
  --cluster ${CLUSTER_ARN} \
  --services ${SERVICE_ARN} \
  --profile ${AWS_PROFILE} \
  | jq '.services[].deployments[0].networkConfiguration')

aws ecs run-task \
--cluster "${CLUSTER_ARN}" \
--task-definition "${TASK_DEF_ARN}" \
--network-configuration "${NETWORK_CONFIG}" \
--launch-type FARGATE \
--profile ${AWS_PROFILE} \
--overrides file://overrides.json

rm -rf ${OVERRIDE_FILE}
