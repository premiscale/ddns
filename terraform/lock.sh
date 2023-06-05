#! /bin/bash

(
    cd ddns/terraform/ && \
    terraform providers lock --platform=linux_amd64 --platform=darwin_amd64 -platform=windows_amd64
)