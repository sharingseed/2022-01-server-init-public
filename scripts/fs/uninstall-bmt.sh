set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

TARGET="/usr/local/bin/bmt"

if [ ! -e "${TARGET}" ]; then
  echo "skip uninstall bmt" >&2
else
  sudo rm -f "${TARGET}"
fi

echo "-- completed --" >&2
echo "" >&2
