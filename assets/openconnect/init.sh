#!/bin/sh
set -ex

apt update -y
apt-get install -y openconnect dante-server netcat
rm -rf /var/cache/apt/* /tmp/* /var/tmp/*

# Get server cert
echo '>> Prepare for starting VPN...' >&2
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

echo '>> Sleep 5s...' >&2
sleep 5
ip add show tun0

echo '>> Starting Socks Server...' >&2
cat /etc/_danted.conf > /etc/danted.conf
service danted restart

# adduser --shell /sbin/nologin --gecos '' preview
# echo 'preview:cftyuhbvg' | chpasswd

echo '>> Ready.' >&2

while true; do
  sleep 1h
done

