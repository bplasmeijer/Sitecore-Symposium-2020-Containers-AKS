# Containers & AKS: Taking Sitecore 10 to the next level

## Installing prerequisite software

- [Install Powershell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7)
- [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) / [Current release of the Azure CLI](https://aka.ms/installazurecliwindows)

The current script will install [Kubernetes](https://kubernetes.io) version ```1.17.11```. If you want to change to another version, please update the scripts.

``` 
# list Azure locations
az account list-locations -o table

# get  Azure locations
az aks get-versions -l west-europe -o table 

KubernetesVersion    Upgrades
-------------------  ------------------------
1.19.0(preview)      None available
1.18.8               1.19.0(preview)
1.18.6               1.18.8, 1.19.0(preview)
1.17.11              1.18.6, 1.18.8
1.17.9               1.17.11, 1.18.6, 1.18.8
1.16.15              1.17.9, 1.17.11
1.16.13              1.16.15, 1.17.9, 1.17.11
```

## Scripts

All the scripts has ```default``` values in place.

Create the Azure resource group, and create Azure Container Registry 
```

.\1.CreateDepends.ps1 -Region ... -ResourceGroup ... -MyRegistry ... -SkuAcr ... 
```
Create the AKS Kubernetes cluster: 
- two Linux nodes (Kubernetes core)
- one Windows node
- assign ACR to cluster
- grep authenticate
```
.\2.CreateAKS.ps1 -Region -ResourceGroup -AksName -AcrName -AzureWindowsPassword   
```
Install the tools:
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Kubernetes CLI)
- [Helm](https://helm.sh/docs/intro/install/) (Package manager CLI)
```
.\3.InstallTools.ps1 -Region -ResourceGroup -AksName -AcrName 
```
Set-up cluster
- deploy helm chart ```ingress-nginx/ingress-nginx```
```
.\4.CreateNginx.ps1
```
Create solution
- Create Kubernetes namespace
- Please check ```1.2.2 Kubernetes secrets``` in the [Installation Guide for Production Environment with Kubernetes](https://dev.sitecore.net/~/media/D6D6C46E2A89478D92CA10BCDD19BBEF.ashx)
- **Set your own secrets based on the guide.**
```
.\5.CreateNamespaceAndSecrets.ps1
```
Deploy the external services
- Microsoft SQL
- Solr
- Redis
```
.\6.Externals.ps1  
```
Intiozalie the external services
- Microsoft SQL
- Solr
```
.\7.Init.ps1
```
Deploy the solution
```
.\8.SolutionAndNginx.ps1
```