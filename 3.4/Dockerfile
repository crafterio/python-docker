FROM phusion/passenger-customizable

MAINTAINER Marc Lopez <marc5.12@outlook.com>

RUN /pd_build/utilities.sh \
    && /pd_build/python.sh \
    && apt-get install python-virtualenv libcurl4-openssl-dev python-pip python2.7-dev build-essential make libssl-dev libffi-dev -y \
    && pip install --upgrade requests[security]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -f /etc/service/nginx/down \
    && rm -f /etc/nginx/sites-enabled/default

ADD application.conf /etc/nginx/sites-enabled/application.conf
