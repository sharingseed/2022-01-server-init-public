set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# 2023/12 deprecated, should use "docker compose"

# Install docker-compose
if [ -x "$(command -v docker-compose)" ]; then
  echo "skip install docker-compose" >&2
else
  if [ ! -x "$(command -v pip3)" ]; then
    sudo apt-get update
    sudo apt-get install -y python3-pip
  fi
  pip3 install docker-compose
fi

echo "-- completed --" >&2
echo "" >&2
