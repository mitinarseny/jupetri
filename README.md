<p align="center">
  <a href="https://github.com/mitinarseny/jupetri">
    <img src=".assets/logo.png" alt="logo" width="20%" />
  </a>
  <h1 align="center">Complete <a href="http://docker.com/">Docker</a> image for <a href="https://jupyter.org">Jupyter</a></h1>
  <p align="center">
    <a href="https://hub.docker.com/r/mitinarseny/jupetri/builds">
      <img alt="Docker Build" src="https://img.shields.io/docker/cloud/build/mitinarseny/jupetri?logo=docker&style=flat-square">
    </a>
  </p>
</p>

## About

This docker image includes:

* [`python`](https://www.python.org) version `3.7.4`
* [`conda`](https://conda.io/) (`miniconda3` version `4.7.10`)
* [`plotly`](https://plot.ly/python/) module with [`orca`](https://github.com/plotly/orca) configured

## Usage

### Dockerize

Create a [`Dockerfile`](https://docs.docker.com/engine/reference/builder/)
in your project root directory with following structure:

```dockerfile
FROM mitinarseny/jupetri

RUN conda install --yes --freeze-installed \
  numpy \
  scipy \
  # and other packages you need
```

Then, in your project root directory create `docker-compose.yaml` with following structure:

```yaml
version: '3.7'

services:
  jupyter:
    build: .
    volumes:
      - ./:/data
    ports:
      - "8888:8888"
```

### Run

To run your Jupyter server simply run:

```bash
docker-compose up --build
```
