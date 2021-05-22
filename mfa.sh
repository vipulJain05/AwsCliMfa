#!/bin/bash

set -e

# specify your MFA_DEVICE_ARN
MFA_DEVICE_ARN="YOUR_MFA_ARN"

case "$MFA_DEVICE_ARN" in
    #case 1
    "YOUR_MFA_ARN") echo "Please specify the MFA_DEVICE_ARN" ;exit 1;;
      
esac
unset aws_access_key_id
unset aws_secret_access_key
unset aws_session_token
echo "Please enter MFA code: " 
read MFA_CODE

echo "You entered '$MFA_CODE'"
COMMAND="aws --output text sts get-session-token \
    --serial-number $MFA_DEVICE_ARN \
    --token-code $MFA_CODE --profile original"
  


#COMMAND="aws sts get-session-token --serial-number $MFA_DEVICE_ARN --token-code $MFA_CODE"

CREDS=$($COMMAND)

KEY=$(echo $CREDS | cut -d" " -f2)
SECRET=$(echo $CREDS | cut -d" " -f4)
SESS_TOKEN=$(echo $CREDS | cut -d" " -f5)

aws configure set aws_access_key_id $KEY
aws configure set aws_secret_access_key $SECRET
aws configure set aws_session_token $SESS_TOKEN
