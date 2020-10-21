Clear-Host

$namespace = "sitecore"

./kubectl create -f ./k8s-sitecore-xm1/external -n $namespace
