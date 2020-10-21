param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Region = 'westeurope',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ResourceGroup = 'Symposium2020',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$MyRegistry = 'Symposium2020',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SkuAcr = 'Standard'  
)

# Setup CLI & Parameters for AKS creation
Write-Host "--- Setting up CLI & Params ---" -ForegroundColor Blue

# create resource group
Write-Host "--- Creating resource group ---" -ForegroundColor Blue
az group create --name $ResourceGroup --location $Region
Write-Host "--- Complete: resource group ---" -ForegroundColor Green

# create resource group
Write-Host "--- Creating ACR ---" -ForegroundColor Blue
az acr create -n $MyRegistry -g $ResourceGroup --sku $SkuAcr --location $Region
Write-Host "--- Complete: ACR ---" -ForegroundColor Green

