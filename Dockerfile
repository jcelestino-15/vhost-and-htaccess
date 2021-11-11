# Place instructions here

FROM ubuntu:latest
ENV DEBIAN_FRONTEND=nonintercative 

#update and install packages
RUN apt update
RUN apt install -y vim
RUN apt install -y apache2
RUN apt install -y sudo
RUN apt install -y apache2-utils

#enable the UserDir module
RUN a2enmod userdir
#enable DirectoryIndex module
RUN a2enmod autoindex

#enabling other Apache modules
RUN a2enmod rewrite
RUN a2enmod alias
RUN a2enmod auth_basic

#user1
RUN adduser jcc65664
RUN passwd -d jcc65664
RUN usermod -aG sudo jcc65664

# Set the working directory to public_html                                   
WORKDIR /home/jcc65664/public_html
# Copy the index.html file into the dir               
COPY index.html .

# User directory
RUN mkdir /home/jcc65664/public_html/Dev
WORKDIR /home/jcc65664/public_html/Dev
COPY indexdev.html .
RUN sudo htpasswd -c .htpasswd Dev
COPY .htaccess .

#creating 3 directories to host the 3 websites
WORKDIR /var/www/html
RUN sudo mkdir -p /site1.internal/public_html
RUN sudo mkdir -p /site2.internal/public_html
RUN sudo mkdir -p /site3.internal/public_html

#modifying permission to web dir
RUN sudo chmod -R 775 /var/www/html

WORKDIR /var/www/html/site1.internal/public_html
COPY site1index.html .

WORKDIR /var/www/html/site2.internal/public_html
COPY site2index.html .

WORKDIR /var/www/html/site3.internal/public_html
COPY site3index.html .

#vHost files of the 3 websites
COPY site1.conf /etc/apache2/sites-available
COPY site2.conf /etc/apache2/sites-available
COPY site3.conf /etc/apache2/sites-available

#enable the 3 websites
RUN sudo a2ensite site1.conf
RUN sudo a2ensite site2.conf
RUN sudo a2ensite site3.conf

#disabling defeault site
RUN sudo a2dissite 000-default.conf

COPY hosts /etc/

# Add in other directives as needed
LABEL Maintainer: "jazmin.celestino.694@my.csun.edu"

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]

