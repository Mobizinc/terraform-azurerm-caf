#!/bin/bash
if [ ! -f /tmp/sublist.json ]
then
   echo '{"sub": "sub"}' > /tmp/sublist.json
   sed -i '$s/}/,\n'\"$sub_name\"':'\"$sub_id\"'}/' /tmp/sublist.json
else
   sed -i '$s/}/,\n'\"$sub_name\"':'\"$sub_id\"'}/' /tmp/sublist.json