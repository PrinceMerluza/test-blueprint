#!/bin/bash

count_failed_case=$(jq '.failed|length' linter-result.json)

counter=0
while [ $counter -lt $count_failed_case ]
do
    failed_case=$(jq .failed[$counter].description linter-result.json)
    id=$(jq ".failed[$counter].id" -r linter-result.json)

    line_counter=0
    count_line_highlights=$(jq ".failed[$counter].fileHighlights|length" linter-result.json)
    while [ $line_counter -lt $count_line_highlights ]
    do
        path=$(jq ".failed[$counter].fileHighlights[$line_counter].path" -r linter-result.json)
        lineFrom=$(jq ".failed[$counter].fileHighlights[$line_counter].lineNumber" linter-result.json)
        lineCount=$(jq ".failed[$counter].fileHighlights[$line_counter].lineCount" linter-result.json)
        lineCount=$(($lineCount-1))
        lineTo=$(($lineFrom+$lineCount))
        # echo "::error file=$path,line=$lineFrom,endLine=$lineTo,title=$id::$failed_case"
        echo "::error file=blueprint/index.md,line=20,endLine=20,title=aaaaa::$failed_case"
        ((line_counter++))
    done

    ((counter++))
done

if [ $count_failed_case -gt 0 ]
then
    exit 1
fi
