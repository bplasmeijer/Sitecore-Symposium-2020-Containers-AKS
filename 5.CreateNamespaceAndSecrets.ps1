Clear-Host

$namespace = "sitecore"

./kubectl create ns sitecore

./kubectl create -k ./k8s-sitecore-xm1/secrets -n $namespace

