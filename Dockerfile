FROM nginx:latest

WORKDIR /etc/nginx/conf.d/

RUN rm default.conf

COPY mysiteconf.conf mysiteconf.conf

