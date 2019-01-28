Connect-AzureRmAccount

$locName="North Europe"
Get-AzureRMVMImageSku -Location $locName -Publisher "MicrosoftVisualStudio" -Offer "VisualStudio" | Select Skus

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName "Visual Studio Professional"
$VmName = "AvanadeDevOps"
$DnsLabelPrefix = "iasko-devops"
$VmIPName = $VmName+"-ip"
$VmAdminUserName = "andrii.iasko"
$VmAdminPassword ="some-secret-password-123"
$ResourceGroupName = "DevOpsAvanadeIPIL"
$ResourceGroupLocation = "North Europe"
$SecureStringPwd = ConvertTo-SecureString $VmAdminPassword -AsPlainText -Force
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force
New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/Avanade/DevOpsHOL/master/azure-rm/azuredeploy.json" `
    -VmName $VmName `
    -VmSize "Standard_D2s_v3" `
    -VmVisualStudioVersion "VS-2017-Ent-Latest-WS2016" `
    -VmAdminUserName $VmAdminUserName `
    -VmAdminPassword $SecureStringPwd `
    -DnsLabelPrefix $DnsLabelPrefix `
    -ChocoPackages 'visualstudiocode;notepadplusplus;googlechrome' `
    -Force -Verbose