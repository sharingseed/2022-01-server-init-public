set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

if [ -n "$(command -v uv)" ]; then
  echo "skip install uv" >&2
else
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source $HOME/.local/bin/env
fi

echo "-- completed --" >&2
echo "" >&2
