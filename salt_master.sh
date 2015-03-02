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

cat <<EOF >/etc/salt/master.d/reactor.conf
reactor:
  - 'salt/auth':
    - /srv/reactor/auth-pending.sls
  - 'salt/minion/*/start':
    - /srv/reactor/auth-complete.sls
  - 'minion_start':
    - /srv/reactor/sync_grains.sls
EOF
service salt-master restart
