#!/bin/bash

#return code 0 = running
#return code 1 = finished successfully
#return code 2 = failed

##now wait for running to go away
#progress_url={$SCA_PROGRESS_URL}/{$SCA_PROGRESS_KEY}

if [ -f finished ]; then
    code=`cat finished`
    if [ $code -eq 0 ]; then
        echo "finished successfully"
        exit 1 #success!
    else
        echo "finished with code:$code"
        exit 2 #failed
    fi
fi

#if [ -f started ]; then
#    echo "running"
#    exit 0 #running!
#fi

if [ -f jobid ]; then
    jobid=`cat jobid`
    jobstate=`qstat -f $jobid | grep job_state | cut -b17`
    if [ -z $jobstate ]; then
        echo "Job removed before completing - maybe timed out?" 
        exit 2
    fi
    if [ $jobstate == "Q" ]; then
        echo "Waiting in the queue"
        eststart=`showstart $jobid | grep start`
        #curl -X POST -H "Content-Type: application/json" -d "{\"msg\":\"Waiting in the PBS queue : $eststart\"}" $SCA_PROGRESS_URL
        exit 0
    fi
    if [ $jobstate == "R" ]; then
        echo "Running"
        exit 0
    fi
    if [ $jobstate == "H" ]; then
        echo "Job held.. waiting"
        exit 0 
    fi

    #assume failed for all other state
    echo "Jobs failed - PBS job state: $jobstate"
    exit 2
fi

echo "can't determine the status!"
exit 3

#echo "running.job.id is gone.. job must have finished"
#code=`cat exit.code`
#curl -X POST -H "Content-Type: application/json" -d "{\"status\": \"finished\", \"msg\":\"lifedemo ended with code:$code\"}" $progress_url
#echo "job finished with code $code"
#exit $code
