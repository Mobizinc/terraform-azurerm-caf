#!/bin/bash
if [ ! -f /tmp/sublist.json ]
then
   echo '{"sub": "sub"}' > /tmp/sublist.json
   sed -i '$s/}/,\n'\"$1\"':'\"$2\"'}/' /tmp/sublist.json
else
   sed -i '$s/}/,\n'\"$1\"':'\"$2\"'}/' /tmp/sublist.json