#!/bin/bash
echo Grabbing instances in all regions, please wait..
for region in `aws ec2 describe-regions --output text | cut -f4`
do
aws rds describe-db-instances --region $region --query 'DBInstances[*].[DBName,DBInstanceIdentifier,AvailabilityZone,DBInstanceStatus,DBInstanceClass,BackupRetentionPeriod,MultiAZ,TagList[?Key==`Name`]| [0].Value,TagList[?Key==`billing`] | [0].Value,TagList[?Key==`environment`] | [0].Value,TagList[?Key==`project`] | [0].Value,TagList[?Key==`contact`] | [0].Value]' --output text >> kk_Tech_RDS.tsv
cat kk_Tech_RDS.tsv | tr "\\t" "," >   kk_Tech_RDS.csv
done

