set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PYTHON_VERSION=${1:-}

if [ -z "${PYTHON_VERSION}" ]; then
  echo "Error: must specify python-version." >&2
  exit 1
fi

source /etc/profile.d/anyenv.sh

# Install python
if [ -z "$(pyenv install --list | grep ${PYTHON_VERSION})" ]; then
  git -C /usr/lib/anyenv/envs/pyenv/plugins/python-build pull
fi
if [ -n "$(pyenv versions --bare | grep ${PYTHON_VERSION})" ]; then
  echo "skip install python ${PYTHON_VERSION}" >&2
else
  sudo apt-get install -y \
    python3-dev build-essential default-libmysqlclient-dev \
    libncursesw5-dev libgdbm-dev libc6-dev libctypes-ocaml-dev \
    zlib1g-dev libsqlite3-dev tk-dev \
    libssl-dev libmysqlclient-dev \
    librust-libsodium-sys-dev liblzma-dev \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev git

  CFLAGS=-I/usr/include/openssl LDFLAGS=-L/usr/lib \
    pyenv install ${PYTHON_VERSION}
fi
if [ "$(pyenv global)" != "${PYTHON_VERSION}" ]; then
  pyenv global ${PYTHON_VERSION}
fi

echo "-- completed --" >&2
echo "" >&2

