set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install yq
if [ -x "$(command -v yq)" ]; then
  echo "skip install yq" >&2
else
  sudo wget -qO /usr/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
  sudo chmod a+x /usr/bin/yq
fi

echo "-- completed --" >&2
echo "" >&2
