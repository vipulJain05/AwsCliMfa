## Enable MFA in AWS
It is mandatory for everyone to create MFA on your AWS accounts to access aws services. Follow the steps to enable MFA for your account

*Steps*  
1.  Go to [https://console.aws.amazon.com/iam/home?region=us-east-2#/security_credentials](https://console.aws.amazon.com/iam/home?region=us-east-2#/security_credentials)
2.  Look for “Multi-factor authentication (MFA)” and click manage MFA
3.  Add a virtual MFA using authenticator App(easiest one)
4.  Log out and log back in. Now you can see sign-in attempt asking for MFA

Confirm by opening 2-3 AWS services which you are expected to have access of.



## Access AWS CLI with MFA
Follow the steps to access aws services like SOPS, kubernetes using aws cli.

***Prerequisites*** :  
-   Open aws credentials file (`~/.aws/credentials` in mac and linux) with suitable editor
-   Change [default] with [original]
-   Save changes and exit

There are two ways to access AWS cli with MFA enabled  

 1. ***Automatic***

	*Steps*:
	- Open [mfa.sh](https://github.com/map-my-customers/infrastructure/tree/master/utils/aws) file.
	 - Replace value of `MFA_DEVICE_ARN` with the respective MFA ARN which can be found at  [https://console.aws.amazon.com/iam/home?region=us-east-2#/security_credentials?credentials=iam](https://console.aws.amazon.com/iam/home?region=us-east-2#/security_credentials?credentials=iam) under  `Multi-factor authentication (MFA)`
	 - Run `sh mfa.sh` under `infrastructure/utils/aws/` and enter token when prompted.

2.  ***Manual***

       *Steps*:
	*   Run the following commands and replace $MFA_DEVICE_ARN and $MFA_CODE with respective mfa ARN and token

			unset aws_access_key_id  
			unset aws_secret_access_key  
			unset aws_session_token  
			aws sts get-session-token --serial-number $MFA_DEVICE_ARN --token-code $MFA_CODE

	*   Run following commands and replace ACCESS_KEY, SECRET_KEY and SESSION_TOKEN with respective values received from previous step

			aws configure set aws_access_key_id ACCESS_KEY  
			aws configure set aws_secret_access_key SECRET_KEY  
			aws configure set aws_session_token SESSION_TOKEN
