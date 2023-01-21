#!/bin/sh

host=rf-database.rf-dashboard-demo.svc.cluster.local
user=postgres
pw=$POSTGRES_PASSWORD
database=postgres

resultdir=`pwd`"/results"

buildnr=20280238
timestep=0

echo host: $host
echo user: $user
echo database: $database

i=0
runs=30
delayfactor=1.2

while [ $i -lt $runs ]
do
    if [ $i = 8 ]; then
       robot -d results/$buildnr -i Team1 -v DF:$delayfactor ./tst
    else
       robot -d results/$buildnr -v DF:$delayfactor ./tst
    fi
    testarchiver --time-adjust-secs $timestep  \
          --dbengine postgresql \
          --host $host \
          --port 5432 \
          --team AutRegTeam \
          --series Regressie#$buildnr \
          --dont-require-ssl \
          --user $user \
          --pw $pw \
          --database $database \
          $resultdir/$buildnr/output.xml

    buildnr=$((buildnr - 1))
    if [ $i -lt 19 ]; then
      delayfactor=$(echo "scale=3; $delayfactor*0.95" | bc -l)
    fi
    timestep=$((timestep - 86400))
    i=$((i + 1))
    echo i: $i
    echo delayfactor: $delayfactor
done