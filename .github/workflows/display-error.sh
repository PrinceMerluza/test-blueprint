#!/bin/bash

count_failed_case=$(jq '.failed|length' linter-result.json)

counter=0
while [ $counter -lt $count_failed_case ]
do
    failed_case=$(jq .failed[$counter].description linter-result.json)

    line_counter=0
    count_line_highlights=$(jq ".failed[$counter].fileHighlights|length" linter-result.json)
    while [ $line_counter -lt $count_line_highlights ]
    do
        path=$(jq ".failed[$counter].fileHighlights[$line_counter].path" linter-result.json)
        lineFrom=$(jq ".failed[$counter].fileHighlights[$line_counter].lineNumber" linter-result.json)
        echo "::error file=blueprint/index.md,line=$lineFrom,endLine=$lineFrom::$failed_case"
        ((line_counter++))
    done

    ((counter++))
done

if [ $count_failed_case -gt 0 ]
then
    exit 1
fi
