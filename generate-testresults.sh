#!/bin/sh

host=rf-database
user=postgres
pw=$POSTGRES_PASSWORD
database=postgres

resultdir=`pwd`"/results"

buildnr=20280014
timestep=0

echo host: $host
echo user: $user
echo database: $database

i=0
while [ $i -lt 30 ]
do
    if [ $i = 8 ]; then
       robot -d results/$buildnr -i Team1 ./tst
    else
       robot -d results/$buildnr ./tst
    fi
    testarchiver --time-adjust-secs $timestep  \
          --dbengine postgresql \
          --host $host \
          --port 5432 \
          --team AutRegTeam \
          --series Regressie#$buildnr.001 \
          --dont-require-ssl \
          --user $user \
          --pw $pw \
          --database $database \
          $resultdir/$buildnr/output.xml

    buildnr=$((buildnr + 1))
    timestep=$((timestep - 86400))
    i=$((i + 1))
    echo i: $i
done