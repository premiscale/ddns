ARG IMAGE=ubuntu
ARG TAG=22.04

FROM ${IMAGE}:${TAG}

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.description "© PremiScale, Inc. 2023"
LABEL org.opencontainers.image.licenses "GPLv3"
LABEL org.opencontainers.image.authors "Emma Doyle <emma@premiscale.com>"
LABEL org.opencontainers.image.documentation "https://premiscale.com"

USER root

ENV AWS_ACCESS_KEY="" \
    AWS_REGION="" \
    AWS_SECRET_KEY="" \
    CRONITOR_TELEMETRY_KEY="" \
    DEVELOPMENT_A_RECORD=""

# Install the Doppler CLI via apt for secrets retrieval.
RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd ddns \
    && useradd -rm -d /opt/ddns -s /bin/bash -g ddns -G sudo -u 1001 ddns \
    && mkdir /app/terraform

# Install Terraform
ARG TERRAFORM_VERSION=1.3.4
RUN curl -sOL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    install terraform /usr/bin/terraform && \
    rm terraform*.zip

# Install cronitor
RUN curl -sOL https://cronitor.io/dl/linux_amd64.tar.gz && \
    tar xvf linux_amd64.tar.gz -C /usr/bin/ && \
    rm linux_amd64.tar.gz

WORKDIR /app
COPY bin/run.sh .
COPY terraform/* terraform/
RUN chown -R ddns:ddns /app \
    && chmod +x run.sh

CMD [ "./run.sh" ]