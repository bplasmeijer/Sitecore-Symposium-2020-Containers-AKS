Clear-Host

Write-Host "--- deployments ---" -ForegroundColor Blue
./kubectl get deployments -n sitecore
Write-Host "--- pods ---" -ForegroundColor Blue
./kubectl get pods -n sitecore
Write-Host "--- update pod ---" -ForegroundColor Blue
./kubectl set image deployments/cd sitecore-xm1-cd=symposium2020.azurecr.io/sxp/sitecore-xm1-cd:10.0.0-ltsc2019-v2 -n sitecore --record
#./kubectl get pods -n sitecore
./kubectl rollout status deployments/cd -n sitecore
Write-Host "--- status ---" -ForegroundColor Blue
#./kubectl rollout undo deployments/cd -n sitecore