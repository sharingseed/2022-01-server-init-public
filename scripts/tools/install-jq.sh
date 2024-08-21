set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install jq
if [ -x "$(command -v jq)" ]; then
  echo "skip install jq" >&2
else
  sudo apt update -y
  sudo apt-get -y install jq
fi

echo "-- completed --" >&2
echo "" >&2
