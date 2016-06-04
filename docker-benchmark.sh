#!/bin/bash

# docker build -t symfony2-cached .
# docker run --rm -ti -v $PWD:/var/www symfony2-cached ./docker-benchmark.sh


STARTAT=$(date +%s)
echo "###### Started at $(date +%T) ($(date +%s)) ######"

rm -f symlink

for i in `seq 1 10`
do

    TIME="%es %C" time rm -rf vendor bin 
    TIME="%es %C" time composer install --no-interaction --quiet
    TIME="%es %C" time app/console --env=prod cache:clear --quiet
    TIME="%es %C" time app/console --env=prod cache:warmup --quiet
done

ln -s app/logs symlink # Crash on Windows

ENDAT=$(date +%s)

let "DURATION=$ENDAT-$STARTAT"

echo "###### Ended at $(date +%T) ($(date +%s)) - duration: ${DURATION}s ######"

