# Variables
$resourceGroup = "MyResourceGroup5"
$vmName = "MyVM"
$location = "centralus"
$alertRuleName = "HighCPUAlert"
$actionGroupName = "MyActionGroup"
$actionGroupShortName = "AGShort"
$emailRecipient = "your-email@example.com"

# Create an Action Group (for notifications)
az monitor action-group create `
  --name $actionGroupName `
  --resource-group $resourceGroup `
  --short-name $actionGroupShortName `
  --action email admin $emailRecipient

# Get Action Group Resource ID
$actionGroupId = "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourceGroup/providers/Microsoft.Insights/actionGroups/$actionGroupName"

# Create CPU Percentage Alert Rule
az monitor metrics alert create `
  --name $alertRuleName `
  --resource-group $resourceGroup `
  --scopes "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourceGroup/providers/Microsoft.Compute/virtualMachines/$vmName" `
  --condition "avg Percentage CPU > 80" `
  --description "Alert when CPU usage exceeds 80%" `
  --severity 2 `
  --evaluation-frequency "PT5M" `
  --window-size "PT5M" `
  --action $actionGroupId
