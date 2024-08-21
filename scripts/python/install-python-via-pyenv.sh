set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

PYTHON_VERSION=${1:-}

# Install python
if [ -z "${PYTHON_VERSION}" ]; then
  echo "Error: did not specified python-version." >&2
  exit 1
fi

if [ -z "$(pyenv install --list | grep ${PYTHON_VERSION})" ]; then
  git -C /usr/lib/anyenv/envs/pyenv/plugins/python-build pull
fi
if [ -n "$(pyenv versions --bare | grep ${PYTHON_VERSION})" ]; then
  echo "skip install python ${PYTHON_VERSION}" >&2
else
  sudo apt-get update
  sudo apt-get install -y \
    build-essential libssl-dev libffi-dev libbz2-dev libdb-dev \
    libreadline-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev \
    zlib1g-dev uuid-dev tk-dev
  CFLAGS=-I/usr/include/openssl LDFLAGS=-L/usr/lib \
    pyenv install ${PYTHON_VERSION}
  if [ "$(pyenv global)" != "${PYTHON_VERSION}" ]; then
    pyenv global ${PYTHON_VERSION}
  fi
fi

echo "-- completed --" >&2
echo "" >&2

