set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

SCRIPT_FILE="/etc/profile.d/set_env_base_url.sh"
if [ -e "${SCRIPT_FILE}" ]; then
  echo "skip add ${SCRIPT_FILE}" >&2
elif [ -n "${BASE_URL:-}" ]; then
  sudo tee ${SCRIPT_FILE} <<EOL
export BASE_URL="${BASE_URL}"
export BASE_URL_DNS_NAME="${BASE_URL_DNS_NAME:-}"
EOL
else
  echo "skip configure, not exist ${SCRIPT_FILE} nor assign BASE_URL" >&2
fi

if [ -e "${SCRIPT_FILE}" ]; then
  FILE="/etc/bash.bashrc"
  SCRIPT=". ${SCRIPT_FILE}"
  if [ -n "$(grep "${SCRIPT}" "${FILE}")" ]; then
    echo "skip append ${FILE}" >&2
  else
    echo "${SCRIPT}" | sudo tee -a "${FILE}" >&2
  fi

  source ${SCRIPT_FILE}
fi

echo "-- completed --" >&2
echo "" >&2
