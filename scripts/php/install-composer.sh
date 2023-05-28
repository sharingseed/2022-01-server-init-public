set -eu
echo "-- install-composer.sh --" >&2

# Install composer
if [ ! -x "$(command -v php)" ] || [ -x "$(command -v composer)" ]; then
  echo "skip install composer" >&2
else
  # Install Composer
  curl -sS https://getcomposer.org/installer | php
fi

echo "completed" >&2
echo "" >&2
