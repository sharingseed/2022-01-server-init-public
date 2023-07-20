set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

# Install pyenv
if [ -n "$(command -v pyenv)" ]; then
  echo "skip install pyenv" >&2
else
  anyenv install pyenv
  source /etc/profile.d/anyenv.sh

  #touch $(pyenv root)/default-packages
fi

echo "-- completed --" >&2
echo "" >&2

