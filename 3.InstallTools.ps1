param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Region = 'westeurope',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ResourceGroup = 'Symposium2020',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$AksName = 'Symposium2020',

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$AcrName = 'Symposium2020'
)

$current = Get-Location

# helm version
$helmVersion = "3.3.4"
# get AKS version
$aksVersion = "1.17.11" #$(az aks get-versions -l $Region --query 'orchestrators[-1].orchestratorVersion' -o tsv)

# # install helm
 Write-Host "--- install Helm ---" -ForegroundColor Blue
curl -LO "https://get.helm.sh/helm-v$helmVersion-windows-amd64.zip"
Expand-Archive "helm-v$helmVersion-windows-amd64.zip" -DestinationPath (Join-Path $current "helm") -Force
$helm = Get-ChildItem -Path (Join-Path $current "helm") -Recurse -Name "helm.exe"
Move-Item (Join-Path $current "helm" $helm) (Join-Path $current "helm.exe") -Force
Remove-Item "helm-v$helmVersion-windows-amd64.zip"
Write-Host "--- Complete Helm install ---" -ForegroundColor Green

# installing Kubectl 
Write-Host "--- Install kubectl ---" -ForegroundColor Blue
curl -LO "https://storage.googleapis.com/kubernetes-release/release/v$aksVersion/bin/windows/amd64/kubectl.exe"
Write-Host "--- Complete kubectl ---" -ForegroundColor Green