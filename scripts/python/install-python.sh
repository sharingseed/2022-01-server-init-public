set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PY_VERSION=${1:-}

if [ -z "${PY_VERSION}" ]; then
  echo "Error: must specify python-version." >&2
  exit 1
fi

# Install python
if [ -n "$(command -v /usr/bin/python${PY_VERSION})" ]; then
  echo "skip install python${PY_VERSION}" >&2
else
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update
  sudo apt -y install python${PY_VERSION} python${PY_VERSION}-venv

  sudo update-alternatives --install /usr/bin/python python /usr/bin/python${PY_VERSION} 1
  sudo update-alternatives --set python /usr/bin/python${PY_VERSION}
fi

echo "-- completed --" >&2
echo "" >&2

