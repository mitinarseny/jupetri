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

RUN addgroup --gid "${JUPYTER_GID}" "${JUPYTER_GROUP}" \
  && adduser \
  --disabled-password \
  --gecos "" \
  --uid "${JUPYTER_UID}" \
  "${JUPYTER_USER}"

RUN pip3 install --upgrade \
  pip \
  virtualenv

ARG VIRTUAL_ENV=/opt/venv
RUN mkdir -p ${VIRTUAL_ENV} \
  && chown -R ${JUPYTER_UID} ${VIRTUAL_ENV}

USER ${JUPYTER_USER}
RUN python3 -m virtualenv --python=python3 "${VIRTUAL_ENV}"
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

COPY --chown=${JUPYTER_USER}:${JUPYTER_GROUP} requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
  && rm /tmp/requirements.txt

RUN jupyter labextension install --clean --no-build \
  @kenshohara/theme-nord-extension \
  @jupyterlab/toc \
  @jupyterlab/latex \
  @krassowski/jupyterlab_go_to_definition \
  @ryantam626/jupyterlab_code_formatter

COPY --chown=${JUPYTER_USER}:${JUPYTER_GROUP} jupyter/ /home/${JUPYTER_USER}/.jupyter/

RUN jupyter lab build

WORKDIR /home/${JUPYTER_USER}

ENTRYPOINT ["jupyter"]
CMD ["lab", "--ip", "0.0.0.0", "--port", "8888", "--no-browser"]
