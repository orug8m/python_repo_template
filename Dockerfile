FROM python:3.9.1-slim-buster

RUN apt-get update && apt-get install -y \
    git \
    gpg \
    vim

WORKDIR /src

ADD . .
RUN pip install -r requirements.txt
