#!/bin/bash

count_failed_case=$(jq '.failed|length' result.json)
count_error_case=$(jq '.error|length' result.json)

counter=0
while [ $counter -lt $count_failed_case ]
do
    failed_case=$(jq .failed[$counter].description result.json)
    echo "::error::$failed_case"
    ((counter++))
done

counter=0
while [ $counter -lt $count_error_case ]
do
    error_case=$(jq .error[$counter] result.json)
    echo "::error::$error_case"
    ((counter++))
done

if [ $count_failed_case -gt 0 ] || [ $count_error_case -gt 0]
then
    exit 1
fi
