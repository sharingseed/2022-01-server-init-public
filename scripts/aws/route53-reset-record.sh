set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

ASSETS_DIR="$(cd $(dirname $0); pwd)/../../assets/route53_reset_record"

# Install script
SOURCE="${ASSETS_DIR}/route53_reset_record.sh"
TARGET="/usr/bin/route53_reset_record.sh"
if [ -e "${TARGET}" ] && diff -q "${TARGET}" "${SOURCE}"; then
  echo "skip install ${TARGET}" >&2
else
  if [ -e "${TARGET}" ]; then
    sudo rm -f "${TARGET}"
  fi
  sudo cp "${SOURCE}" "${TARGET}"
fi

# Install service
SOURCE="${ASSETS_DIR}/route53_reset_record.service"
TARGET="/etc/systemd/system/route53_reset_record.service"
if [ -e "${TARGET}" ] && diff -q "${TARGET}" "${SOURCE}"; then
  echo "skip install ${TARGET}" >&2
else
  if [ -e "${TARGET}" ]; then
    sudo rm -f "${TARGET}"
  fi
  sudo cp "${SOURCE}" "${TARGET}"
  sudo systemctl daemon-reload
  sudo systemctl enable --now route53_reset_record.service
fi

echo "-- completed --" >&2
echo "" >&2
