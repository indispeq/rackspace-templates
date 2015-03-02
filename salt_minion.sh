#!/usr/bin/env bash

environment=$1
master=$2
roles=($3)

cat <<EOF >/etc/salt/minion
master: $master
grains:
  env: $environment
  roles: 
EOF

for role in "${roles[@]}"
do
	echo "    - ${role}" >> /etc/salt/minion
done 

service salt-minion restart

