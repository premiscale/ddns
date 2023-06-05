#! /bin/bash

(
    cd ddns/terraform/ && \
    ME="$(curl -sL ifconfig.me)" && \
    doppler --token "$(pass show doppler/production-service-token)" run -- terraform plan -compact-warnings -input=false -no-color -state=.terraform/.terraform.tfstate -out terraform.plan \
        -var "domain=premiscale.com" \
        -var "aws_access_key=$AWS_ACCESS_KEY" \
        -var "aws_secret_key=$AWS_SECRET_KEY" \
        -var "aws_region=$AWS_REGION" \
        -var "domain_record=chelsea.ops.premiscale.com" \
        -var "ip=$ME"
)