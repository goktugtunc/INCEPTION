FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server procps gettext && \
    apt-get clean

RUN mkdir -p /run/mysqld && mkdir -p /docker-entrypoint-initdb.d && chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/config.sh /config.sh
COPY conf/init.sql.template /tmp/init.sql.template
COPY .env /tmp/env_vars

RUN chmod +x /config.sh && \
    export $(grep -v '^#' /tmp/env_vars | xargs) && \
    envsubst < /tmp/init.sql.template > /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

CMD ["sh", "/config.sh"]
