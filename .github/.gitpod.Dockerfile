FROM mambaorg/micromamba:1.5.1

ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# Instala Git y herramientas básicas
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    nano \
    less \
    && rm -rf /var/lib/apt/lists/*

# Copia y crea el entorno bioinformático
COPY environment.yml /tmp/environment.yml

RUN micromamba create -y -n bioenv -f /tmp/environment.yml && \
    micromamba clean --all --yes

SHELL ["/bin/bash", "-c"]
