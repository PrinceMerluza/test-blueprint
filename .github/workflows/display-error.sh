#!/bin/bash

count_failed_case=$(jq '.failed|length' result.json)

counter=0
while [ $counter -lt $count_failed_case ]
do
    failed_case=$(jq .failed[$counter].description linter-result.json)
    echo "::error::$failed_case"
    ((counter++))
done

if [ $count_failed_case -gt 0 ]
then
    exit 1
fi
