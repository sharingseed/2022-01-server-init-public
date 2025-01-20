#!/bin/bash

if [ -z "${BASE_URL_ZONE_ID}" ]; then
  if [ -z "${BASE_URL_DNS_NAME}" ]; then
    BASE_URL_DNS_NAME=$(echo ${BASE_URL} | sed -e 's/[^.]\+\.//')
  fi
  BASE_URL_ZONE_ID=$(
    aws route53 list-hosted-zones-by-name \
      --dns-name "${BASE_URL_DNS_NAME}" \
      --output text \
      --query 'HostedZones[0].Id'
  )
fi
if [ -z "${BASE_URL_ZONE_ID}" ] || [ "${BASE_URL_ZONE_ID}" == "None" ] ; then
  echo "BASE_URL_ZONE_ID is not set"
  exit 1
fi


TOKEN=$(
  curl -s \
    -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
    -X PUT "http://169.254.169.254/latest/api/token"
)
IP_ADDRESS=$(
  curl -s \
    -H "X-aws-ec2-metadata-token: $TOKEN" \
    http://169.254.169.254/latest/meta-data/public-ipv4
)
if [ -z "${IP_ADDRESS}" ]; then
  echo "IP_ADDRESS is not set"
  exit 1
fi

BATCH_JSON='{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "'*'.'${BASE_URL}'",
        "Type": "A",
        "TTL" : 300,
        "ResourceRecords": [
          { "Value": "'${IP_ADDRESS}'" }
        ]
      }
    }
  ]
}'

aws route53 change-resource-record-sets \
  --hosted-zone-id "${BASE_URL_ZONE_ID}" \
  --change-batch "${BATCH_JSON}"
