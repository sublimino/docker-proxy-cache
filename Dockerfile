FROM ubuntu:16.04

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid \
 && mv /etc/squid/squid.conf /etc/squid/squid.conf.dist \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y apt-cacher-ng supervisor
RUN apt-get install -y python python-pip
RUN pip install -q -U devpi-server

COPY squid.conf /etc/squid/squid.conf
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir /scripts
COPY *.sh /scripts/
RUN chmod 755 /scripts/*.sh

VOLUME ["${SQUID_CACHE_DIR}"]
VOLUME ["/var/cache/apt-cacher-ng"]
VOLUME ["/var/.devpi/server"]

EXPOSE 3128
EXPOSE 3141
EXPOSE 3142

CMD /usr/bin/supervisord -n
