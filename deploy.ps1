#Requires -Version 4

$AwsProfile="default"
$S3BucketName="sam-datadog-extension"
$CloudFormationStackName="sam-datadog-extension"

sam build --parallel

aws s3 mb s3://$S3BucketName --endpoint-url https://s3.us-east-1.amazonaws.com --profile $AwsProfile

aws s3api wait bucket-exists --bucket $S3BucketName --endpoint-url https://s3.us-east-1.amazonaws.com --profile $AwsProfile

sam package --output-template-file .\packaged.yaml --s3-bucket $S3BucketName --profile $AwsProfile

sam deploy --template-file .\packaged.yaml --stack-name $CloudFormationStackName --capabilities CAPABILITY_IAM