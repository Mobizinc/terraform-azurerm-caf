#! /bin/bash

set -x

appName="iam-automation-nonprod-dev"
graphId=$(az ad sp list --query "[?appDisplayName=='Microsoft Graph'].appId | [0]" --all --out tsv)
echo "graphId is $graphId"
#principalId=$(az resource list -n $appName --query [*].identity.principalId --out tsv)
principalId="42c89358-21df-44dd-8437-f9071772c038"
echo "principalId is $principalId"
graphResourceId=$(az ad sp list --display-name "Microsoft Graph" --query [0].id --out tsv)
echo "graphResourceId is $graphResourceId"
appRoleIds=($(az ad sp show --id $graphId --query "appRoles[?value=='Application.Read.All'].id | [0]" --out tsv) $(az ad sp show --id $graphId --query "appRoles[?value=='Application.ReadWrite.All'].id | [0]" --out tsv) $(az ad sp show --id $graphId --query "appRoles[?value=='Policy.Read.All'].id | [0]" --out tsv) $(az ad sp show --id $graphId --query "appRoles[?value=='Policy.ReadWrite.ApplicationConfiguration'].id | [0]" --out tsv) $(az ad sp show --id $graphId --query "appRoles[?value=='Directory.Read.All'].id | [0]" --out tsv) $(az ad sp show --id $graphId --query "appRoles[?value=='User.Read.All'].id | [0]" --out tsv))

for appRoleId in "${appRoleIds[@]}";
do
  echo "appRoleId is $appRoleId"
	body='{"principalId":"'"$principalId"'","resourceId":"'"$graphResourceId"'","appRoleId":"'"$appRoleId"'"}'
	az rest --method post --uri https://graph.microsoft.com/v1.0/servicePrincipals/$principalId/appRoleAssignments --body $body --headers Content-Type=application/json
  echo "appRoleId: $appRoleId is assigned"
done
