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

ADD requirements.txt .

RUN pip3 install -r requirements.txt

# Ugly workaround but otherwise we will get an error while the lib tries to get education info on a person
RUN sudo sed -i 's/self\.get_educations\(\)//' /usr/local/lib/python3.8/dist-packages/linkedin_scraper/person.py

ADD . .

USER 1200
