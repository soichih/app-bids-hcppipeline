
FROM bids/hcppipelines:v3.17.0-13
MAINTAINER Soichi Hayashi <hayashis@iu.edu>

#TODO - container seems to be broken
#https://github.com/BIDS-Apps/HCPPipelines/issues/22

#make it work under singularity on karst
RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft

