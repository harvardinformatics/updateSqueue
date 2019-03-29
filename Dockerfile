FROM debian

# Intended to be used for testing purposes, linked to a database called squeue-db

EXPOSE 80
RUN apt-get update -y && apt-get install -y \
    procps \
    mariadb-client-10.1 \
    libmariadbclient-dev-compat \
    python \
    python-mysqldb \
    python-nose \
    supervisor

COPY etc/supervisor.conf /etc/supervisor/conf.d/app.conf

WORKDIR /app
ADD . /app

CMD ["/usr/bin/supervisord","-n"]
