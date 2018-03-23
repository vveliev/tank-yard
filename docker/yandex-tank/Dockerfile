FROM buildpack-deps:stretch-curl

MAINTAINER Alexey Lavrenuke <direvius@yandex-team.ru>

ENV DEBIAN_FRONTEND noninteractive
ENV YANDEX_TANK_VERSION=1.9.10

RUN echo "deb http://deb.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/tucows.list; \
    apt-get update && apt-get install -y -q --no-install-recommends software-properties-common gcc && \
    add-apt-repository ppa:yandex-load/main -y && \
    apt-get update && apt-get install -y --allow-unauthenticated -q  phantom phantom-ssl python-dev python-virtualenv && \
    mkdir -p /var/loadtest


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -q && \
    apt-get install --no-install-recommends -yq \
        sudo     \
        vim      \
        wget     \
        curl     \
        less     \
        iproute2 \
        software-properties-common \
        telnet   \
        atop     \
        openssh-client \
        python-pip  && \
    add-apt-repository ppa:yandex-load/main -y && \
    apt-get update -q && \
    apt-get install -yq \
        phantom \
        phantom-ssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*

ENV TELEGRAF_VERSION=1.4.3-1
RUN gpg --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5 && \
    wget --progress=dot:giga https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}_amd64.deb.asc && \
    wget --progress=dot:giga https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    gpg --batch --verify telegraf_${TELEGRAF_VERSION}_amd64.deb.asc telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    dpkg -i telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    rm -f telegraf_${TELEGRAF_VERSION}_amd64.deb*

ENV BUILD_DEPS="python-dev build-essential gfortran libssl-dev libffi-dev"
# Create virtual environment
# Upgrade PIP in virtual environment to latest version
RUN virtualenv /appenv && \
    apt-get update && \
    apt-get install -yq --no-install-recommends ${BUILD_DEPS} && \
    . /appenv/bin/activate && \
    pip install --upgrade pip &&        \
    pip install --upgrade setuptools && \
    pip install https://github.com/yandex/yandex-tank/archive/v${YANDEX_TANK_VERSION}.zip && \
    apt-get autoremove -y ${BUILD_DEPS} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/* /root/.cache/*


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