#!/bin/sh

AWS_PROFILE=secbokapp-cdk

if [ "$1" = "" ]; then
  echo "ERROR: require env param."
  echo "ex) ./opt/regist_rails_master_key.sh local"
  exit
fi

MASTER_KEY=`cat config/master.key`
aws secretsmanager update-secret --secret-id rails-master-key-$1 --secret-string {\"railsMasterKey\":\"${MASTER_KEY}\"} --profile ${AWS_PROFILE}
