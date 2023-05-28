set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install docker-compose
if [ -x "$(command -v docker-compose)" ]; then
  echo "skip install docker-compose" >&2
else
  if [ ! -x "$(command -v pip3)" ]; then
    sudo apt-get update
    sudo apt-get install -y python3-pip
  fi
  sudo -H pip3 install docker-compose
fi

echo "-- completed --" >&2
echo "" >&2
