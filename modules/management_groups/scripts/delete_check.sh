#!/bin/bash
export nameAvailable=false
until $nameAvailable
do
export nameAvailable=$(az account management-group check-name-availability --name $1 | jq .nameAvailable)
echo "waiting to resouce get created"
done
echo "resource created succesfully"