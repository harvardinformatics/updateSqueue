FROM debian:buster

# Intended to be used for testing purposes, linked to a database called squeue-db

EXPOSE 80
RUN apt-get update -y && apt-get install -y \
    procps \
    mariadb-client-10.3 \
    libmariadbclient-dev-compat \
    python \
    python-mysqldb \
    python-nose \
    python-setuptools \
    supervisor \
    sssd \
    sssd-tools

COPY etc/supervisor.conf /etc/supervisor/conf.d/app.conf

WORKDIR /app
ADD . /app
RUN python setup.py install
CMD ["/usr/bin/supervisord","-n"]
