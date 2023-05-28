set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

# Install nodenv
if [ -n "$(command -v nodenv)" ]; then
  echo "skip install nodenv" >&2
else
  anyenv install nodenv
  source /etc/profile.d/anyenv.sh

  touch $(nodenv root)/default-packages
fi

echo "-- completed --" >&2
echo "" >&2
