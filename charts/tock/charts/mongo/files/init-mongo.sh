#!/bin/bash
# Script to init mongo cluster

if [ -z "${MONGO_SVC}" ]; then
  echo "Please specify MONGO_SVC variable" ; exit 1
fi

echo "Waiting for startup.."
for i in 0 1 2
do
  until mongo --host ${MONGO_SVC}-${i}.${MONGO_SVC}:27017 --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
    printf '.'
    sleep 1
  done
  echo ; echo "Node $i started"
done
echo "All node Started.."

echo setup.sh time now: `date +"%T" `

mongo --host ${MONGO_SVC}-0.${MONGO_SVC}:27017 <<EOF
   var cfg = {
        "_id": "tock",
        "members": [
            {
                "_id": 0,
                "host": "${MONGO_SVC}-0.${MONGO_SVC}:27017"
            },
            {
                "_id": 1,
                "host": "${MONGO_SVC}-1.${MONGO_SVC}:27017"
            },
            {
                "_id": 2,
                "host": "${MONGO_SVC}-2.${MONGO_SVC}:27017"
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOF

echo "Configuration is done"