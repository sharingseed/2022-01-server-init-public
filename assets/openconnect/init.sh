#!/bin/sh
set -ex

apt update -y
apt-get install -y openconnect openssh-client openssh-server netcat
rm -rf /var/cache/apt/* /tmp/* /var/tmp/*

# Get server cert
set +ex
SERVER_RES=$(echo $VPN_PASSWORD | openconnect -q --cookieonly --passwd-on-stdin -u ${VPN_USER} --servercert "" ${VPN_OPTIONS} ${VPN_URL} 2>&1)
set -ex
if [[ "$SERVER_RES" =~ (sha256:[0-9a-f]+) ]]; then
  SERVER_CERT=${BASH_REMATCH[1]}
elif [[ "$SERVER_RES" =~ (--servercert) ]]; then
  SERVER_CERT=`echo "$SERVER_RES" | grep '\-\-servercert' | awk '{print $NF}'`
fi
if [ -z "${SERVER_CERT}" ]; then
  echo 'Failed to get server cert.' >&2
  exit 1
else
	echo "SERVER_CERT: ${SERVER_CERT}" >&2
fi

# Get cookie
COOKIE=`echo $VPN_PASSWORD | openconnect -q --cookieonly --passwd-on-stdin -u ${VPN_USER} --servercert ${SERVER_CERT} ${VPN_OPTIONS} ${VPN_URL}`
if [ -z "${COOKIE}" ]; then
  echo 'Failed to get cookie.' >&2
  exit 1
else
	echo "COOKIE: ${COOKIE}" >&2
fi

echo '>> Starting VPN...' >&2
echo $COOKIE | openconnect -b --cookie-on-stdin --servercert ${SERVER_CERT} ${VPN_OPTIONS} ${VPN_URL}
echo '>> VPN connected.' >&2

# Make ssh tunnel
echo '>> Starting SSH Server...' >&2
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
fi
if [ ! -d /run/sshd ]; then
  mkdir -p /run/sshd
fi
/usr/sbin/sshd -D &

echo ">> Waiting for sshd to start..."
until nc -z -w3 localhost 22; do echo "sshd is unavailable - waiting" && sleep 2 ; done
echo ">> sshd is ready"

echo ">> Starting tunnel to ${TUNNEL_TARGET}..."
if [ ! -f /root/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""
  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
fi
# TUNNEL_OPTIONS="-gfCN4 -L0.0.0.0:10001:163.220.177.15:22 -D 10002"
ssh \
  -o ServerAliveInterval=60 \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/dev/null \
  -i /root/.ssh/id_rsa root@localhost \
  ${TUNNEL_OPTIONS}
echo ">> tunnel is ready"
