set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

PY_VERSION=${1:-}

if [ -z "${PY_VERSION}" ]; then
  echo "Error: must specify python-version." >&2
  exit 1
fi

if [ -n "$(uv python find ${PY_VERSION} 2>/dev/null)" ]; then
  echo "skip install python ${PY_VERSION}" >&2
else
  uv python install "${PY_VERSION}"
fi

echo "-- completed --" >&2
echo "" >&2
