set -eu
echo "-- install-php.sh --" >&2

source /etc/profile.d/anyenv.sh

# Install phpenv
if [ -n "$(command -v phpenv)" ]; then
  echo "skip install phpenv" >&2
else
  # Install phpenv
  anyenv install phpenv
  source /etc/profile.d/anyenv.sh
fi

echo "completed" >&2
echo "" >&2
