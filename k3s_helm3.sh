curl -O https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz
tar xvf helm-v3.2.4-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm ls

# install kubernetes dashboard 
# 
https://blog.csdn.net/judyjie/article/details/85217617
docker pull mirrorgooglecontainers/kubernetes-dashboard-amd64:v1.10.1
docker tag mirrorgooglecontainers/kubernetes-dashboard-amd64:v1.10.1 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
docker rmi mirrorgooglecontainers/kubernetes-dashboard-amd64:v1.10.1
