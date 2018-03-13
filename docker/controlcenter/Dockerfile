FROM buildpack-deps:stretch-curl

RUN apt-get update && \
    apt-get install -qy \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb


# Create virtual environment
# Upgrade PIP in virtual environment to latest version


WORKDIR /controlcenter
ENV HOME /controlcenter
ADD app/ /controlcenter

RUN virtualenv /controlcenter/venv && \
    . /controlcenter/venv/bin/activate && \
    pip install pip --upgrade && \
    pip install --upgrade setuptools  && \
    pip install uwsgi && \
    pip install git+https://github.com/yandex/yandex-tank.git@master#egg=yandextank && \
    pip install -r requirements.txt && \

EXPOSE 80
CMD uwsgi --ini uwsgi.ini

# Add entrypoint script
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]