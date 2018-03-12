FROM python:2.7
RUN mkdir -p /controlcenter
WORKDIR /controlcenter
ENV HOME /controlcenter
ADD requirements.txt /controlcenter
RUN apt-get update && \
    apt-get install -y vim
RUN pip install --upgrade setuptools
RUN pip install uwsgi
RUN pip install git+https://github.com/yandex/yandex-tank.git@master#egg=yandextank
RUN pip install -r requirements.txt
ADD api.py api.yaml server.py uwsgi.ini /controlcenter/
EXPOSE 80
CMD uwsgi --ini uwsgi.ini