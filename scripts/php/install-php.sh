set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PHP_VERSION=${1:-}

if [ -z "${PHP_VERSION}" ]; then
  echo "Error: must specify php-version." >&2
  exit 1
fi

source /etc/profile.d/anyenv.sh

# Install php
if [ -n "$(phpenv versions --bare | grep ${PHP_VERSION})" ]; then
  echo "skip install php ${PHP_VERSION}" >&2
else
  # Install modules
  # 先頭に`configure_option -R "--with-pdo-mysql"`のように追加
  #vi $(phpenv root)/plugins/php-build/share/php-build/definitions/${PHP_VERSION}

  # Install build tools
  sudo apt-get -y install \
    build-essential \
    libxml2-dev libssl-dev libbz2-dev \
    libcurl4-openssl-dev libzip-dev libjpeg-dev libpng-dev \
    libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev autoconf \
    pkg-config sqlite3 libsqlite3-dev libonig-dev

  # Install php
  phpenv install ${PHP_VERSION}
  phpenv global ${PHP_VERSION}
fi

echo "completed" >&2
echo "" >&2

