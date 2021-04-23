FROM python
#  for python we are using centos as base image 
# centos image will be downloaded from Docker hub if not present 
MAINTAINER  ashutoshh@linux.com 
# if someone is looking for any help then can connect here 
RUN  yum  install python3  -y
RUN pip3  install numpy pandas 
# installing python in centos docker image 
RUN mkdir /pycode 
# creating directory to store python code inside docker image 
COPY  while.py  /pycode/while.py
#ADD https://github.com/redashu/ciscoapr192021/tree/day1docker/while.py /pycode/
# copy will copy data from docker client to docker image during build time 
CMD  ["python3","/pycode/while.py"]
# cmd is for fixing default process of container from this docker image 
# inshort cmd can decide the parent process for this docker image