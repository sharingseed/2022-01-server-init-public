#!/bin/sh
set -ex

function _install_packages() {
  LOG_FILE="/var/log/packages_installed"
  if [ -f "${LOG_FILE}" ]; then
    echo "Packages have been installed."
    return
  fi
  apt update -y
  apt-get install -y openconnect dante-server
  rm -rf /var/cache/apt/* /tmp/* /var/tmp/*
  echo "at $(date +%Y-%m-%d_%H:%M:%S)" > "${LOG_FILE}"
}

function _connect_vpn() {
  if [ "$(ip add show tun0)" ]; then
    echo 'VPN is already connected.'
    return
  fi
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

  echo '>> Wait for ready tun0...' >&2
  while true; do
    sleep 5
    if [ "$(ip add show tun0)" ]; then
      ip add show tun0
      echo '>> Ready.' >&2
      break
    fi
  done
}

function _start_proxy() {
  echo '>> Starting Socks Server...' >&2
  cat /etc/_danted.conf > /etc/danted.conf
  service danted restart
}

function _init() {
  _install_packages
  _connect_vpn
  _start_proxy

  set +ex

  while true; do
    sleep 5
    if [ ! "$(ip add show tun0 >/dev/nul 2>/dev/null)" ]; then
      _connect_vpn
    fi
  done
}

${1:-_init}
