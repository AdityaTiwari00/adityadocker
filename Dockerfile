FROM centos:7

# Install Apache
#RUN yum -y update
RUN yum -y install httpd httpd-tools

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
&& rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install PHP
RUN yum -y install php72w php72w-bcmath php72w-cli php72w-common php72w-gd php72w-intl php72w-ldap php72w-mbstring \
    php72w-mysql php72w-pear php72w-soap php72w-xml php72w-xmlrpc

# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

EXPOSE 443
EXPOSE 80

# Start Apache
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
#RUN systemctl restart httpd
RUN mv /usr/bin/systemctl /usr/bin/systemctl.old
RUN curl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py > /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
