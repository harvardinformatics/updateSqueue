FROM centos:7

# Intended to be used for testing purposes, linked to a database called squeue-db

EXPOSE 80
RUN yum install -y epel-release && yum -y update && yum -y clean all && yum install -y \
    git \
    gcc \
    procps \
    mariadb-devel \
    python \
    python-devel \
    python2-pip \
    python-ldap \
    MySQL-python \
    supervisor

COPY etc/supervisor.conf /etc/supervisor/conf.d/app.conf

WORKDIR /app
ADD . /app
RUN python setup.py install
CMD ["/usr/bin/supervisord","-n"]
