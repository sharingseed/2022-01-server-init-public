set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

NODE_VERSION=${1:-}

if [ -z "${NODE_VERSION}" ]; then
  echo "Error: must specify node-version." >&2
  exit 1
fi

source /etc/profile.d/anyenv.sh

# Install node
if [ -z "$(nodenv install --list | grep ${NODE_VERSION})" ]; then
  git -C /usr/lib/anyenv/envs/nodenv/plugins/node-build pull
fi
if [ -n "$(nodenv versions --bare | grep ${NODE_VERSION})" ]; then
  echo "skip install node ${NODE_VERSION}" >&2
else
  nodenv install ${NODE_VERSION}
fi
if [ "$(nodenv global)" != "${NODE_VERSION}" ]; then
  nodenv global ${NODE_VERSION}
fi

echo "-- completed --" >&2
echo "" >&2

