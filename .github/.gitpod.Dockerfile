FROM mambaorg/micromamba:1.5.1

ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

COPY environment.yml /tmp/environment.yml

RUN micromamba create -y -n bioenv -f /tmp/environment.yml && \
    micromamba clean --all --yes

SHELL ["/bin/bash", "-c"]
