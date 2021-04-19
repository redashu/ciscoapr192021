# Docker COntainer getting started. 

## docker for everyone 

<img src="dall.png">

# application deployment model history 

## bare-metal / hardware based app depoyment 

<img src="hardware.png">

## virtualization based app depoyment 

<img src="virt.png">

## Problem with VM's

<img src="vmprob.png">

# COntainers all the way 

<img src="cont.png">

# Introdution to cRE

<img src="cre.png">


# Introduction to DOcker 

<img src="version.png">

## Installation of Docker in Mac/W10 using docker Desktop 

# Docker architecture 

<img src="darch.png">

## Installing Docker engine in LInux server (amazon linux / centos / rhel / fedora )

```
[root@ip-172-31-71-211 ~]# yum  install  docker  
Failed to set locale, defaulting to C
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core                                                                                    | 3.7 kB  00:00:00     
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 0:19.03.13ce-1.amzn2 will be installed
--> Processing Dependency: runc >= 1.0.0 for package: docker-19.03.13ce-1.amzn2.x86_64
--> Processing Dependency: containerd >= 1.3.2 for package: docker-19.03.13ce-1.amzn2.x86_64
--> Processing Dependency: pigz for package: docker-19.03.13ce-1.amzn2.x86_64
--> Processing Dependency: libcgroup for package: docker-19.03.13ce-1.amzn2.x86_64
--> Running transaction check
---> Package containerd.x86_64 0:1.4.4-1.amzn2 will be installed
---> Package libcgroup.x86_64 0:0.41-21.amzn2 will be installed
---> Package pigz.x86_64 0:2.3.4-1.amzn2.0.1 will be installed
---> Package runc.x86_64 0:1.0.0-0.1.20210225.git12644e6.amzn2 will be installed
--> Finished Dependency Resolution

Dependencies Resolved


```

## COnfigure Docker engine as TCP socket 

```
[root@ip-172-31-71-211 ~]# cd  /etc/sysconfig/
[root@ip-172-31-71-211 sysconfig]# ls
acpid       console         grub        man-db           nfs            rpcbind    sshd
atd         cpupower        i18n        modules          raid-check     rsyncd     sysstat
authconfig  crond           init        netconsole       rdisc          rsyslog    sysstat.ioconf
chronyd     docker          irqbalance  network          readonly-root  run-parts
clock       docker-storage  keyboard    network-scripts  rpc-rquotad    selinux
[root@ip-172-31-71-211 sysconfig]# vim docker
[root@ip-172-31-71-211 sysconfig]# cat  docker
# The max number of open files for the daemon itself, and all
# running containers.  The default value of 1048576 mirrors the value
# used by the systemd service unit.
DAEMON_MAXFILES=1048576

# Additional startup options for the Docker daemon, for example:
# OPTIONS="--ip-forward=true --iptables=true"
# By default we limit the number of open files per container
OPTIONS="--default-ulimit nofile=1024:4096  -H tcp://0.0.0.0:2375"
# enable docker  tcp socket 

# How many seconds the sysvinit script waits for the pidfile to appear
# when starting the daemon.
DAEMON_PIDFILE_TIMEOUT=10

```

## start docker server / engine 

```
[root@ip-172-31-71-211 sysconfig]# systemctl  start  docker 
[root@ip-172-31-71-211 sysconfig]# systemctl enale  docker 
Unknown operation 'enale'.
[root@ip-172-31-71-211 sysconfig]# systemctl enable  docker 
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
[root@ip-172-31-71-211 sysconfig]# netstat -nlpt
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1827/rpcbind        
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      2581/sshd           
tcp        0      0 127.0.0.1:43225         0.0.0.0:*               LISTEN      32432/containerd    
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      2314/master         
tcp6       0      0 :::2375                 :::*                    LISTEN      32484/dockerd   

```







