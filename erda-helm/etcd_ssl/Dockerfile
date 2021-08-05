FROM debian:9.8
RUN apt update && apt install  openssl  -y && apt install  gettext-base -y 
RUN mkdir /opt/etcd_ssl
WORKDIR /opt/etcd_ssl
COPY ./fn /opt/etcd_ssl/fn 
COPY ./fn-ssl /opt/etcd_ssl/fn-ssl 
COPY ./generate_ssl.sh /opt/etcd_ssl/generate_ssl.sh
COPY ./templates /opt/etcd_ssl/templates
COPY ./etcd_ssl /opt/etcd_ssl/etcd_ssl
RUN chmod +x /opt/etcd_ssl/generate_ssl.sh
ENTRYPOINT /opt/etcd_ssl/etcd_ssl
