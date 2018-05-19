FROM ubuntu:latest

USER root
RUN apt-get update
RUN apt-get install -y nginx nodejs
RUN apt-get install -y openssl
RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/
ADD web /usr/share/nginx/html/
RUN mkdir /etc/nginx/ssl
ADD web /var/www/html/
RUN openssl req -x509 -sha256 -newkey rsa:2048 -keyout /etc/nginx/ssl/cert.key -out /etc/nginx/ssl/cert.pem -days 1024 -nodes -subj "/CN=localhost"
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
CMD service nginx start