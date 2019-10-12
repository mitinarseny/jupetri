ARG BASE_CONTAINER=python:3.7.4-slim-buster
FROM $BASE_CONTAINER as builder

LABEL maintainer="Arseny Mitin <mitinarseny@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE NO

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:${PATH}

RUN apt-get update --fix-missing \
    && apt-get install --yes --no-install-recommends \
    curl \
    gnupg2

RUN curl -sL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && apt-get install --yes --no-install-recommends \
    gcc \
    python3-dev \
    xvfb \
    libgtk2.0-0 \
    libgconf-2-4 \
    chromium \
    xauth \
    && apt-get clean --yes \
    && apt-get autoclean --yes \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://repo.anaconda.com/miniconda/Miniconda3-4.7.10-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc

RUN conda install --yes --freeze-installed \
    --channel plotly \
    nomkl \
    jupyter \
    plotly \
    plotly-orca \
    psutil \
    requests \
    && conda clean --all --force-pkgs-dirs --yes

WORKDIR /data

ENTRYPOINT ["jupyter"]
CMD ["notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
EXPOSE 8888
