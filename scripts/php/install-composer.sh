set -eu
echo "-- install-composer.sh --" >&2

# Install composer
if [ -n "$(command -v composer)" ]; then
  echo "skip install composer" >&2
else
  # Install Composer
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
fi

echo "completed" >&2
echo "" >&2
