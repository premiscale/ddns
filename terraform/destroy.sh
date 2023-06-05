#! /bin/bash

(
    cd ddns/terraform/ && \
    terraform destroy -auto-approve
)