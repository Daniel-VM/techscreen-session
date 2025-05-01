FROM ubuntu:20.04 

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    bzip2 \
    ca-certificates \
    sudo \
    software-properties-common \
    gnupg \
    lsb-release \
    openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda config --add channels defaults \
    && conda config --add channels bioconda \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict

RUN conda update --quiet --yes --all \
    && conda create --quiet --yes --name ibbis \
        python=3.10 \
        mamba \
        nf-core \
        nf-test \
        nextflow \
        hmmer \
        blast \
        fastqc \
        multiqc \
        samtools \
        bedtools \
        biopython \
        pandas \
        matplotlib \
        jupyterlab \
        black \
        prettier \
        pre-commit \
        pytest-workflow \
        pip \
    && conda clean --all --force-pkgs-dirs --yes \
    && echo "source activate ibbis" >> ~/.bashrc

RUN curl -fsSL https://get.nextflow.io | bash \
    && mv nextflow /usr/local/bin/ \
    && chmod +x /usr/local/bin/nextflow

RUN nextflow -version

WORKDIR /workspace