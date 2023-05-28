set -eu
echo "-- install-php73.sh --" >&2

# Install php 7.3.28
if [ -n "$(phpenv versions --bare | grep 7.3.28)" ]; then
  echo "skip install php 7.3.28" >&2
else
  # Install modules
  # 先頭に`configure_option -R "--with-pdo-mysql"`のように追加
  #vi $(phpenv root)/plugins/php-build/share/php-build/definitions/7.4.20

  # Install build tools
  sudo apt-get -y install build-essential 
  sudo apt-get -y install libxml2-dev libssl-dev libbz2-dev \
    libcurl4-openssl-dev libzip-dev libjpeg-dev libpng-dev \
    libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev autoconf
  sudo apt-get -y install pkg-config sqlite3

  # Install php
  phpenv install 7.3.28
  phpenv global 7.3.28
fi

echo "completed" >&2
echo "" >&2
