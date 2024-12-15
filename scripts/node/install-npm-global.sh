set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

COMMAND=${1:-}

if [ -z "${COMMAND}" ]; then
  echo "Error: must specify npm-package-name." >&2
  exit 1
fi

source /etc/profile.d/anyenv.sh

if [ -n "$(nodenv which ${COMMAND} 2>/dev/null)" ]; then
  echo "skip install ${COMMAND}" >&2
else
  echo "npm install-global ${COMMAND}" >&2
  npm i -g ${COMMAND}
  nodenv rehash
fi

echo "-- completed --" >&2
echo "" >&2

