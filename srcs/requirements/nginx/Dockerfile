FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl iputils-ping gettext && \
    apt-get clean

COPY conf/default.conf /etc/nginx/templates/default.conf

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]