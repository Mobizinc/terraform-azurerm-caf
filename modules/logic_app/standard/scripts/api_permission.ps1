$appName = "iam-automation-logicapp"
#$subscriptionId = "07a79cf7-b968-4cce-964b-61086331dacd"
#az account set --subscription $subscriptionId
$graphId = az ad sp list --query "[?appDisplayName=='Microsoft Graph'].appId | [0]" --all
$principalId = $(az resource list -n $appName --query [*].identity.principalId --out tsv)
$graphResourceId = $(az ad sp list --display-name "Microsoft Graph" --query [0].id --out tsv)
$appRoleIds = $(az ad sp show --id $graphId --query "appRoles[?value=='Application.Read.All'].id | [0]"), $(az ad sp show --id $graphId --query "appRoles[?value=='Application.ReadWrite.All'].id | [0]"), $(az ad sp show --id $graphId --query "appRoles[?value=='Policy.Read.All'].id | [0]"), $(az ad sp show --id $graphId --query "appRoles[?value=='Policy.ReadWrite.ApplicationConfiguration'].id | [0]"), $(az ad sp show --id $graphId --query "appRoles[?value=='Directory.Read.All'].id | [0]"), $(az ad sp show --id $graphId --query "appRoles[?value=='User.Read.All'].id | [0]")
foreach ($appRoleId in $appRoleIds)
{
	$body = "{'principalId':'$principalId','resourceId':'$graphResourceId','appRoleId':'$appRoleId'}"
	az rest --method post --uri https://graph.microsoft.com/v1.0/servicePrincipals/$principalId/appRoleAssignments --body $body --headers Content-Type=application/json 
}
