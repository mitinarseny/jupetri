ARG BASE_CONTAINER=python:3.8.0-slim-buster
FROM $BASE_CONTAINER as builder

LABEL maintainer="Arseny Mitin <mitinarseny@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    gcc \
    g++ \
    libfreetype6-dev \
    pkg-config \
  && apt-get clean --yes \
  && apt-get autoclean --yes \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip \
  && pip install \
      jupyter \
      matplotlib \
      plotly

WORKDIR /data

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
EXPOSE 8888
