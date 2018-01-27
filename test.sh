#!/bin/bash

#singularity exec docker://brainlife/bids-hcppipelines:v3.17.0-14 python /run.py --n_cpus 8 --license_key $FREESURFER_LICENSE input ./ participant
singularity exec -e docker://brainlife/bids-hcppipelines:v3.17.0-14 whoami

