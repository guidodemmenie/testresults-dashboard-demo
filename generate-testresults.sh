#!/bin/bash

USER="<usr>"
PW="<pw>"
HOST="x.x.x.x"
DB="test-archive"

RESULTDIR=`pwd`"/results"
echo  $RESULTDIR

buildnr=20280014
timestep=0

for i in {1..50}
do
    buildnr=$((buildnr + 1)) 
    timestep=$((timestep + 120))
    robot -d results ./tst
    testarchiver --time-adjust-secs $timestep  --dbengine postgresql --host $HOST --port 5432 --team AutRegTeam --series Regressie#$buildnr.001 --dont-require-ssl --user $USER --pw $PW --database $DB $RESULTDIR/output.xml
    sleep 1s
done