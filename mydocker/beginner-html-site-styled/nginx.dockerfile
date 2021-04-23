FROM  nginx 
# default image from docker hub 
MAINTAINER  ashutoshh@Linux.com , 9509957594
COPY .  /usr/share/nginx/html/
# coping everything from dockerfile location to nginx documentroot inside 
# docker image during image build time 
# Note: if you are not writing cmd then previous image CMD will be inherited  
