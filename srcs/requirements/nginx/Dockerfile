FROM debian:buster

RUN apt update -y && \
    apt upgrade -y && \
    apt install nginx -y && \
    mkdir -p /etc/nginx/ssl && \
    apt install openssl -y && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Mulhouse/O=42/OU=42/CN=ngalzand.42.fr/UID=ngalzand" && \
    mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/conf.d/myconf.conf

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
