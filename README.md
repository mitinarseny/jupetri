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

* [`python`](https://www.python.org) version `3.8.0`
* [`plotly`](https://plot.ly/python/)
* [`matplotlib`](https://matplotlib.org/index.html)

## Usage

### List dependencies

You will need to list all your python dependencies in `requirements.txt`.
To list all python modules via `pip`:

```bash
pip freeze > requirements.txt
```

Or with `conda`:

```bash
conda list -e > requirements.txt
```

### Dockerize

Create a [`Dockerfile`](https://docs.docker.com/engine/reference/builder/)
in your project root directory with following structure:

```dockerfile
FROM mitinarseny/jupetri

COPY requirements.txt .

RUN pip install -r requirements.txt
```

Then, in your project root directory create [`docker-compose.yaml`](https://docs.docker.com/compose/compose-file/) with following structure:

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
