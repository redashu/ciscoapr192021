FROM centos
# using centos as base image 
# if this image will not be present then automatically pulled from Docker HUb
MAINTAINER  ashutoshh@linux.com 
# dev info
RUN yum install httpd -y
COPY ashu.html  /var/www/html/index.html 
# apache httpd read file by the name of index.html as default page 
# /var/www/html/ is the default location for apache httpd
# copy is coping data from local to docker image during build process
ADD  k8s.png  /var/www/html/k8s.png
# as of now ADD is same as COPY 
EXPOSE 80 
# setting default port info it will be used during container creation time 
ENTRYPOINT  httpd  -DFOREGROUND
# ENTRYPOINT -- command will start httpd web server the moment we create container
