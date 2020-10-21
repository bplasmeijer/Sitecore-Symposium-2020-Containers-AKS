Clear-Host

$namespace = "sitecore"

./kubectl create -f ./k8s-sitecore-xm1 -n $namespace

./kubectl create -f ./k8s-sitecore-xm1/ingress-nginx -n $namespace