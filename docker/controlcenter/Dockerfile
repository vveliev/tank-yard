FROM buildpack-deps:stretch-curl

RUN apt-get update && \
    apt-get install -qy \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

# Create virtual environment
# Upgrade PIP in virtual environment to latest version


WORKDIR /controlcenter
ENV HOME /controlcenter

RUN virtualenv /controlcenter/venv && \
    . /controlcenter/venv /bin/activate && \
    pip install pip --upgrade

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend


ADD requirements.txt /controlcenter

RUN pip install --upgrade setuptools
RUN pip install uwsgi
RUN pip install git+https://github.com/yandex/yandex-tank.git@master#egg=yandextank
RUN pip install -r requirements.txt
ADD api.py api.yaml server.py uwsgi.ini /controlcenter/
EXPOSE 80
CMD uwsgi --ini uwsgi.ini