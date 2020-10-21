Start-Process clear
# create resource group
Write-Host "--- Creating nginx (Ingress) ---" -ForegroundColor Blue

# Create a namespace for your ingress resources
.\kubectl create namespace ingress-basic

# add nginx helm charts
.\helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# update the charts
.\helm repo update

.\helm install nginx-ingress ingress-nginx/ingress-nginx `
    --namespace ingress-basic `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux 

    Write-Host "--- Complete: nginx (ingress) ---" -ForegroundColor Green

$ingressIpAddress = (kubectl get svc nginx-ingress-ingress-nginx-controller -n ingress-basic -o jsonpath="{.status.loadBalancer.ingress[*].ip}")

if (-not [string]::IsNullOrEmpty($ingressIpAddress)) {
  Write-Verbose "Ingress DNS record: $ingressIpAddress"
}

Write-Host "--- Complete: nginx (ingress) ---" -ForegroundColor Green