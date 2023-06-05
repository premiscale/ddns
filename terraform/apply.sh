#! /bin/bash

(
    cd ddns/terraform/ && \
    doppler --token "$(pass show doppler/production-service-token)" run -- terraform apply -compact-warnings -input=false -state=.terraform/.terraform.tfstate -auto-approve terraform.plan
)
