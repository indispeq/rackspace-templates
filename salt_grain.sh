#!/usr/bin/env bash

cat <<EOF >/etc/salt/minion
master: `cat /tmp/saltmaster.txt` 
id: `hostname`
grains:
  env: `cat /tmp/environment.txt`
  roles:
EOF

array=( `cat /tmp/roles.txt | tr ',' ' '` )

for role in "${array[@]}"
do
        echo "    - ${role}" >> /etc/salt/minion
done

