cd
mkdir develop
cd develop

#git clone k3s
git clone https://github.com/cloud4mama/qyk3s.git

#download helm linux amd64
wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
tar  zvxf helm-v3.3.4-linux-amd64.tar.gz
cp ./linux-amd64/helm /usr/bin/helm

#helm charts 
git clone https://github.com/helm/charts.git

#ubuntu docker install
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun


#Kubernetes从k8s.gcr.io拉取镜像失败问题
解决办法，可从国内的镜像仓库下载下来，通过docker tar指令修改成相应的版本，示例如下：


docker pull registry.cn-beijing.aliyuncs.com/zhoujun/pause-amd64:3.1
docker pull registry.cn-beijing.aliyuncs.com/zhoujun/kube-proxy-amd64:v1.11.3

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/kube-scheduler-amd64:v1.11.3

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/coredns:1.1.3

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/pause:3.1

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/kube-controller-manager-amd64:v1.11.3

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/kube-apiserver-amd64:v1.11.3

docker pull registry.cn-beijing.aliyuncs.com/zhoujun/etcd-amd64:3.2.18


#然后修改版本：


docker tag registry.cn-beijing.aliyuncs.com/zhoujun/kube-proxy-amd64:v1.11.3 k8s.gcr.io/kube-proxy-amd64:v1.11.3

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/kube-scheduler-amd64:v1.11.3 k8s.gcr.io/kube-scheduler-amd64:v1.11.3

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/kube-apiserver-amd64:v1.11.3 k8s.gcr.io/kube-apiserver-amd64:v1.11.3

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/kube-controller-manager-amd64:v1.11.3 k8s.gcr.io/kube-controller-manager-amd64:v1.11.3

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/etcd-amd64:3.2.18  k8s.gcr.io/etcd-amd64:3.2.18

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/pause:3.1  k8s.gcr.io/pause:3.1

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/coredns:1.1.3  k8s.gcr.io/coredns:1.1.3

docker tag registry.cn-beijing.aliyuncs.com/zhoujun/pause-amd64:3.1  k8s.gcr.io/pause-amd64:3.1


# start k3s
./qyk3s/k3s server --docker --write-kubeconfig /root/.kube/config --write-kubeconfig-mode 666

#use helm to install redis
helm --kubeconfig ~/.kube/config install redis --generate-name

#
./k3s kubectl get pods

#
apt install redis
# kill redis-server process
./qyk3s/k3s kubectl get secret --namespace default redis-1602504212 -o jsonpath="{.data.redis-password}" | base64 --decode
./qyk3s/k3s kubectl port-forward --namespace default svc/redis-1602504212-master 6379:6379
redis-cli



root@iZwz9ciqdmy5swlk0g9jczZ:~/develop/charts/stable# helm --kubeconfig ~/.kube/config install redis --generate-name
