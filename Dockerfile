FROM jupyter/pyspark-notebook:latest

USER root
COPY requirements.txt .
# COPY notebooks/example.ipynb .
RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG NB_GID=100

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN groupadd -f ${USER} && \
    chown -R ${USER}:${USER} ${HOME}

USER ${NB_USER}

RUN export PACKAGES="org.elasticsearch:elasticsearch-spark-30_2.12:8.15.1,io.delta:delta-core_2.12:2.4.0"
RUN export PYSPARK_SUBMIT_ARGS="--packages ${PACKAGES} pyspark-shell"