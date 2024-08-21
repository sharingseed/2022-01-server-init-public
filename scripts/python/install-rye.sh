set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

if [ -n "$(command -v rye)" ]; then
  echo "skip install rye" >&2
else
  curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
  source "$HOME/.rye/env"
fi

FILE="$HOME/.profile"
SCRIPT='source "$HOME/.rye/env"'
if [ -n "$(grep "${SCRIPT}" "${FILE}")" ]; then
  echo "skip append ${FILE}" >&2
else
  echo "${SCRIPT}" | sudo tee -a "${FILE}" >&2
fi

echo "-- completed --" >&2
echo "" >&2
