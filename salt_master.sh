#!/usr/bin/env bash

su git -c 'git init --bare /var/git/novasalt'
sudo git clone /var/git/novasalt /srv
sudo chown -R git:git /srv
su git -c 'cat <<EOF >/var/git/novasalt/hooks/post-update
#!/bin/sh
cd /srv/ || exit
unset GIT_DIR
git pull origin master 
exec git-update-server-info
#sudo salt '*' state.highstate
EOF'
su git -c 'chmod +x /var/git/novasalt/hooks/post-update'

