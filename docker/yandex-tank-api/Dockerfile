FROM buildpack-deps:stretch-curl

MAINTAINER Alexey Lavrenuke <direvius@yandex-team.ru>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://deb.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/tucows.list; \
    apt-get update && apt-get install -y -q --no-install-recommends software-properties-common && \
    add-apt-repository ppa:yandex-load/main -y && \
    apt-get update && apt-get install -y --allow-unauthenticated -q phantom phantom-ssl python python-pip  && \
    mkdir /tank-api-workdir

# Create virtual environment
# Upgrade PIP in virtual environment to latest version
RUN pip install pip --upgrade && \
    pip install yandextank && pip install yandex-tank-api

RUN echo "net.ipv4.tcp_max_tw_buckets=65536" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_tw_recycle=1" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_tw_reuse=0" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_max_syn_backlog=131072" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_syn_retries=3" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_synack_retries=3" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_retries1=3" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_retries2=8" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_rmem=16384 174760 349520" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_wmem=16384 131072 262144" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_mem=262144 524288 1048576" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_max_orphans=65536" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_fin_timeout=10" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_low_latency=1" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_syncookies=0" >> /etc/sysctl.conf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8888/tcp