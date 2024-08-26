set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

if [ -n "$(command -v uv)" ]; then
  echo "skip install uv" >&2
else
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source "$HOME/.cargo/env"
fi

# FILE="$HOME/.profile"
# SCRIPT='export PATH=$PATH:$HOME/.cargo/bin'
# if [ -n "$(grep "${SCRIPT}" "${FILE}")" ]; then
#   echo "skip append ${FILE}" >&2
# else
#   echo "${SCRIPT}" | sudo tee -a "${FILE}" >&2
# fi

echo "-- completed --" >&2
echo "" >&2
