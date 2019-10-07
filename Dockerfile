ARG BASE_CONTAINER=python:3.7.4-slim-buster
FROM $BASE_CONTAINER

LABEL maintainer="Arseny Mitin <mitinarseny@gmail.com>"

ARG JUPYTER_USER="jupetri"
ARG JUPYTER_UID="12345"
ARG JUPYTER_GROUP="petri"
ARG JUPYTER_GID="54321"

RUN apt-get update \
  && apt-get install -y \
    curl \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y \
    nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

RUN addgroup --gid "${JUPYTER_GID}" "${JUPYTER_GROUP}" \
  && adduser \
  --disabled-password \
  --gecos "" \
  --uid "${JUPYTER_UID}" \
  "${JUPYTER_USER}"

USER ${JUPYTER_USER}
ENV PYTHONUSERBASE="/home/${JUPYTER_USER}/.local/"
ENV PATH="${PYTHONUSERBASE}/bin:${PATH}"

COPY --chown=${JUPYTER_USER}:${JUPYTER_GROUP} requirements.txt /tmp/
RUN pip3 install --user --no-cache-dir -r /tmp/requirements.txt \
  && rm /tmp/requirements.txt

ENV JUPYTERLAB_DIR="${PYTHONUSERBASE}/share/jupyter/lab"
ENV JUPYTERLAB_SETTINGS_DIR="/home/${JUPYTER_USER}/.jupyter/lab/user-settings/"

RUN jupyter labextension install --clean --no-build \
  @kenshohara/theme-nord-extension \
  @jupyterlab/toc \
  @jupyterlab/latex \
  @krassowski/jupyterlab_go_to_definition \
  @ryantam626/jupyterlab_code_formatter \
  > /dev/null

RUN mkdir -p "${JUPYTERLAB_SETTINGS_DIR}"
COPY --chown=${JUPYTER_USER}:${JUPYTER_GROUP} settings/ ${JUPYTERLAB_SETTINGS_DIR}

RUN jupyter lab build > /dev/null

ENV JUPYTERLAB_WORK_DIR="/home/${JUPYTER_USER}/work"
RUN mkdir -p "${JUPYTERLAB_WORK_DIR}"

WORKDIR ${JUPYTERLAB_WORK_DIR}

ENTRYPOINT ["jupyter"]
CMD ["lab", "--ip=0.0.0.0", "--port=8888", "--no-browser"]

EXPOSE 8888
