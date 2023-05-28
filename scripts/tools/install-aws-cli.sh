set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install aws-cli
if [ -x "$(command -v aws)" ]; then
  echo "skip install aws-cli" >&2
else
  sudo apt-get -y install awscli
fi

echo "-- completed --" >&2
echo "" >&2
