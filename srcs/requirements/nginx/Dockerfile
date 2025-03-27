FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl iputils-ping gettext && \
    apt-get clean

COPY conf/default.conf.template /etc/nginx/templates/default.conf.template
COPY ./.env /tmp/env_vars
COPY tools/setup.sh /setup.sh
ARG DOMAIN_NAME
ENV DOMAIN_NAME=${DOMAIN_NAME}
RUN chmod +x /setup.sh
    
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]
