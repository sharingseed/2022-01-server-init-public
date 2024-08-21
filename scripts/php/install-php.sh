set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PHP_VERSION=${1:-}

if [ -z "${PHP_VERSION}" ]; then
  echo "Error: must specify php-version." >&2
  exit 1
fi

# Install php
if [ -n "$(command -v /usr/bin/php${PHP_VERSION})" ]; then
  echo "skip install php${PHP_VERSION}" >&2
else
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:ondrej/php
  sudo apt update
  sudo apt -y install php${PHP_VERSION}

  sudo update-alternatives --install /usr/bin/php php /usr/bin/php${PHP_VERSION} 1
  sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}
fi

echo "-- completed --" >&2
echo "" >&2
