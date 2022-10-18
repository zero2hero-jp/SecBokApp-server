#!/bin/sh

AWS_PROFILE=secbokapp-cdk
MASTER_KEY=`cat config/master.key`

if [ "${TARGET_ENV}" = "" ]; then
  echo '[Error]'
  echo '- TARGET_ENV param required. [ local | dev | prod ]'
  echo '- ex) TARGET_ENV=local ./ops/regist_rails_master_key.sh'
  exit 1
fi

aws secretsmanager update-secret --secret-id rails-master-key-${TARGET_ENV} --secret-string {\"railsMasterKey\":\"${MASTER_KEY}\"} --profile ${AWS_PROFILE}
