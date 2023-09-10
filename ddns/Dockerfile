FROM ubuntu:22.04

USER root

ENV AWS_ACCESS_KEY \
    AWS_REGION=us-east-2 \
    AWS_SECRET_KEY \
    CRONITOR_TELEMETRY_KEY

# Install the Doppler CLI via apt for secrets retrieval.
RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/*

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
COPY ddns/scripts/run.sh .
RUN mkdir terraform
COPY ddns/terraform/* terraform/

CMD [ "./run.sh" ]