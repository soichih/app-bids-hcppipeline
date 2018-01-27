#!/bin/bash
docker build -t brainlife/bids-hcppipelines . && \
    docker tag brainlife/bids-hcppipelines brainlife/bids-hcppipelines:v3.17.0-14 && \
    docker push brainlife/bids-hcppipelines
