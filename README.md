# Quick revision of docker & kubernetes 

<img src="rev.png">

## few ideas about minikube once more

## checking and starting minikube based cluster 

```
❯ minikube status
minikube
type: Control Plane
host: Stopped
kubelet: Stopped
apiserver: Stopped
kubeconfig: Stopped

❯ minikube start
😄  minikube v1.19.0 on Darwin 11.2.3
✨  Using the docker driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🔄  Restarting existing docker container for "minikube" ...
🐳  Preparing Kubernetes v1.20.2 on Docker 20.10.5 .../ 



```

## checking cluster context 

```
❯ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

❯ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
*         minikube                      minikube     minikube           default


```

## switching cluster in k8s 

```
❯ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
*         minikube                      minikube     minikube           default
❯ kubectl  get  nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   42d   v1.20.2
❯ kubectl  config  use-context  kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
❯ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
          minikube                      minikube     minikube           default
❯ kubectl  get  nodes
NAME                            STATUS   ROLES                  AGE     VERSION
ip-172-31-69-220.ec2.internal   Ready    control-plane,master   4d13h   v1.21.0
ip-172-31-70-124.ec2.internal   Ready    <none>                 4d13h   v1.21.0
ip-172-31-75-3.ec2.internal     Ready    <none>                 4d13h   v1.21.0

```


## Out of the Box 

### How to add a new minion node into existing k8s cluster

### installing docker and starting engine 

```
[root@ip-172-31-70-176 ~]# yum  install  docker  -y
Failed to set locale, defaulting to C
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 0:20.10.4-1.amzn2 will be installed
--> Processing Dependency: runc >= 1.0.0 for package: docker-20.10.4-1.amzn2.x86_64
--> Processing Dependency: libcgroup >= 0.40.rc1-5.15 for package: docker-20.10.4-1.amzn2.x86_64
--> Processing Dependency: containerd >= 1.3.2 for package: docker-20.10.4-1.amzn2.x86_64
--> Processing Dependenc

===

[root@ip-172-31-70-176 ~]# systemctl  enable --now docker  
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
[root@ip-172-31-70-176 ~]# systemctl status  docker 
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2021-04-22 05:03:04 UTC; 4s ago
     Docs: https://docs.docker.com
  Process: 3906 ExecStartPre=/usr/libexec/docker/docker-setup-runtimes.sh (code=exited, status=0/SUCCESS)
  Process: 3896 ExecSta
  
  
 ```
 
 ### step 2  Enable kernel bridge support for CNI 
 
 ```
 [root@ip-172-31-70-176 ~]# modprobe br_netfilter
[root@ip-172-31-70-176 ~]# echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
[root@ip-172-31-70-176 ~]# 

```

### step 3  Installing. kubeadm installer 

```
cat  <<EOF  >/etc/yum.repos.d/kube.repo
[kube]
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgcheck=0
EOF

-===
yum install kubeadm -y

```

### step 4 Take token from Master Node 

```
[root@ip-172-31-69-220 ~]# kubeadm  token create  --print-join-command 
kubeadm join 172.31.69.220:6443 --token ettzp4.mc39a9035qt5ox27 --discovery-token-ca-cert-hash sha256:8ed2fe7fc3f8679079eec978bb0aef615801d21ad

```
## step 5 assign token to the system you want to configure as Minion Node 

```
kubeadm join 172.31.69.220:6443 --token ettzp4.mc39a9035qt5ox27 --discovery-token-ca-cert-hash sha256:8ed2fe7fc3f8679079eec978bb0aef615801d21adc285ca5faa6456e90f41235
[preflight] Running pre-flight checks
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
	[WARNING FileExisting-tc]: tc not found in system path
	[WARNING Service-Kubelet]: kubelet se
  
  ```
  
  ### step 6 start and enable kubelet. agent 
  
  ```
  [root@ip-172-31-70-176 ~]# systemctl enable --now kubelet 
Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /usr/lib/systemd/system/kubelet.service.

```


## checking from client machine for node updation 

<img src="nodeadd.png">

# POd communication 

## creating a pod 
###  refer aspod1.yml  

```
❯ kubectl  replace  -f aspod1.yaml --force
pod "ashupod1" deleted
pod/ashupod1 replaced
❯ kubectl  get  pods
NAME        READY   STATUS             RESTARTS   AGE
anwepod1    0/1     CrashLoopBackOff   3          87s
ashupod1    1/1     Running            0          7s

```






 
 
  

