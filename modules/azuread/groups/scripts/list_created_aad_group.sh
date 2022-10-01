#!/bin/bash
if [ ! -f /tmp/aadlist.json ]
then
   echo '{}' > /tmp/aadlist.json
   echo "$(jq --arg aadnamearg "$aad_group_name" --arg aadidarg "$aad_group_id" '. += {"\($aadnamearg)": $aadidarg}' /tmp/aadlist.json)" > /tmp/aadlist.json
else
   echo "$(jq --arg aadnamearg "$aad_group_name" --arg aadidarg "$aad_group_id" '. += {"\($aadnamearg)": $aadidarg}' /tmp/aadlist.json)" > /tmp/aadlist.json
fi
