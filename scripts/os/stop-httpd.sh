set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

SERVICE_NAME=apache2
if ! sudo systemctl is-active --quiet $SERVICE_NAME; then
  echo "skip stop httpd." >&2
else
  sudo systemctl disable apache2
  sudo systemctl stop apache2
fi

echo "-- completed --" >&2
echo "" >&2
