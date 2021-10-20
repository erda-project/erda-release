FROM alpine:3.13
WORKDIR /opt/registry_ssl

COPY ./templates ./templates
COPY ./bin/registry_ssl .

COPY ./generate_ssl.sh /opt/registry_ssl/

RUN apk --no-cache add openssl bash gettext \
  && chmod +x /opt/registry_ssl/generate_ssl.sh



ENTRYPOINT /opt/registry_ssl/registry_ssl
