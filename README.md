<p align="center">
  <a href="https://github.com/mitinarseny/jupetri">
    <img src=".assets/logo.png" alt="logo" width="20%" />
  </a>
  <h1 align="center">Complete <a href="http://docker.com/">Docker</a> image for <a href="https://jupyter.org">Jupyter</a> Lab</h1>
  <p align="center">
    <a href="https://hub.docker.com/r/mitinarseny/jupetri/builds">
      <img alt="Docker Build" src="https://img.shields.io/docker/cloud/build/mitinarseny/jupetri?logo=docker&style=flat-square">
    </a>
  </p>
</p>

## About
This docker image includes [Jupyter Lab](https://github.com/jupyterlab/jupyterlab) with following extensions and features:
* [Nord Theme](https://www.nordtheme.com): [@kenshohara/theme-nord-extension](https://github.com/kenshohara/theme-nord-extension)
* [Latex](https://www.latex-project.org) support: [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
 
## Usage
### List Dependencies
In your project root create file `requirements.txt` for dependencies. Then run following:
```bash
pip freeze > requirements.txt
``` 
### Dockerize
Create a [`Dockerfile`](https://docs.docker.com/engine/reference/builder/)
in your project root directory with following structure:
```dockerfile
FROM mitinarseny/jupetri:latest

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt
```
Then, in your project root directory create `docker-compose.yaml` with following structure:
```yaml
version: '3.7'

services:
  lab:
    build: .
    volumes:
      - ./:/home/jupetri/
    ports:
      - "8888:8888"
```
### Run
To run JupyterLab simply do following:
```bash
docker-compose up --build
```
### Deploy
Build image:
``bash
docker build -t <user>/<repo>:<tag> .
``
You can optionally build your image and push it to docker registry (e.g. [DockerHub](https://hub.docker.com)).
Firstly, create a repository, then `docker login` and push finally:
```bash
docker push <user>/<repo>:<tag>
```
