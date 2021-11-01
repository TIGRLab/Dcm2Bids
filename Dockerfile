# Use Ubuntu 20.04 LTS
FROM ubuntu:latest

# Prepare environment
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    ca-certificates \
                    curl \
                    unzip \
                    git

WORKDIR /src/dcm2niix_build

RUN curl -sSLO https://github.com/rordenlab/dcm2niix/releases/latest/download/dcm2niix_lnx.zip && \
    unzip dcm2niix_lnx.zip && \
    rm dcm2niix_lnx.zip

ENV PATH="/src/dcm2niix_build/:$PATH"

WORKDIR /

# Installing and setting up miniconda
RUN curl -sSLO https://repo.continuum.io/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh && \
    bash Miniconda3-py38_4.9.2-Linux-x86_64.sh -b -p /usr/local/miniconda && \
    rm Miniconda3-py38_4.9.2-Linux-x86_64.sh

# Set CPATH for packages relying on compiled libs (e.g. indexed_gzip)
ENV PATH="/usr/local/miniconda/bin:$PATH" \
    CPATH="/usr/local/miniconda/include:$CPATH" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PYTHONNOUSERSITE=1

ADD . /src/Dcm2Bids

WORKDIR /src/Dcm2Bids

RUN python setup.py install

WORKDIR /

ENTRYPOINT ["dcm2bids"]