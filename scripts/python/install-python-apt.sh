set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PYTHON_VERSION=${1:-}

if [ -z "${PYTHON_VERSION}" ]; then
  echo "Error: must specify python-version." >&2
  exit 1
fi

# Install python
if [ -n "$(command -v python${PYTHON_VERSION})" ]; then
  echo "skip install python${PYTHON_VERSION}" >&2
else
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update
  sudo apt -y install python${PYTHON_VERSION} python${PYTHON_VERSION}-venv
fi

#sudo update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1
#sudo update-alternatives --set python /usr/bin/python${PYTHON_VERSION}


echo "-- completed --" >&2
echo "" >&2

