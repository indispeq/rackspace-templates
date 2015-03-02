#!/usr/bin/env bash

su git -c 'git init --bare /var/git/novasalt'
sudo git clone /var/git/novasalt /srv
su git -c 'cat <<EOF >/var/git/novasalt/hooks/post-update'
\#!/bin/sh
exec git update-server-info
cd /srv
git pull
\#sudo salt '*' state.highstate
EOF
