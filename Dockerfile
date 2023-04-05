FROM selenium/standalone-chrome:111.0

WORKDIR /opt/ps

USER root

RUN \
    apt-get update \
    && apt-get install -y \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD . .

RUN pip3 install -r requirements.txt

USER 1200
