#!/usr/bin/env bash

cat <<EOF >/etc/salt/minion
master: $1
grains:
  env: $2
  roles:
EOF

array=( $3 )

for role in "${array[@]}"
do
        echo "    - ${role}" >> /etc/salt/minion
done

