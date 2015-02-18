#!/usr/bin/env bash

cat <<EOF >/etc/salt/minion
master: $1 
grains:
  env: $2
  roles: 
EOF

roles=($3)

for role in "${roles[@]}"
do
        echo "    - ${role}" >> /etc/salt/minion
done

