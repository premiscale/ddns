#! /bin/bash
# Ensure that DNS in AWS is pointed at my home WAN address.

(curl "https://cronitor.link/p/$CRONITOR_TELEMETRY_KEY/ddns?state=run" && (
    ME="$(curl -sL ifconfig.me)" && \
    cd terraform/ || exit 1 && \
    terraform init -input=false -no-color && \
    terraform plan -compact-warnings -input=false -no-color -state=.terraform/.terraform.tfstate -out terraform.plan \
        -var "domain=premiscale.com" \
        -var "aws_access_key=$AWS_ACCESS_KEY" \
        -var "aws_secret_key=$AWS_SECRET_KEY" \
        -var "aws_region=$AWS_REGION" \
        -var "domain_record=$A_RECORD" \
        -var "ip=$ME" && \
    terraform apply -compact-warnings -input=false -state=.terraform/.terraform.tfstate -auto-approve terraform.plan && \
    curl "https://cronitor.link/p/$CRONITOR_TELEMETRY_KEY/ddns?state=complete"
)) || curl "https://cronitor.link/p/$CRONITOR_TELEMETRY_KEY/ddns?state=fail"