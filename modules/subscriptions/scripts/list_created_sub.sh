#!/bin/bash
if [ ! -f /tmp/sublist.json ]
then
   echo '{}' > /tmp/sublist.json
   echo "$(jq --arg subnamearg "$sub_name" --arg subidarg "$sub_id" '. += {"\($subnamearg)": $subidarg}' /tmp/sublist.json)" > /tmp/sublist.json
else
   echo "$(jq --arg subnamearg "$sub_name" --arg subidarg "$sub_id" '. += {"\($subnamearg)": $subidarg}' /tmp/sublist.json)" > /tmp/sublist.json
fi