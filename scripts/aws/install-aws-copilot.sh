set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install cuda
if [ -x "$(command -v copilot)" ]; then
  echo "skip install aws-copilot" >&2
else
  curl -Lo /tmp/copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux
  chmod +x /tmp/copilot
  sudo mv /tmp/copilot /usr/local/bin/copilot
fi

echo "-- completed --" >&2
echo "" >&2
