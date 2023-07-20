set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

# Install poetry
if [ -n "$(command -v poetry)" ]; then
  echo "skip install poetry" >&2
else
  curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
  source $HOME/.poetry/env
  poetry config virtualenvs.in-project true
fi

echo "-- completed --" >&2
echo "" >&2

