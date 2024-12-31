set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

YARN_VERSION=${1:-4.5.3}
HOME_DIR=${2:-$HOME}

cd ${HOME_DIR}

if yarn --version | grep -q "^${YARN_VERSION}$"; then
  echo "skip upgrading yarn to v${YARN_VERSION}" >&2
else
  echo "upgrading yarn to v${YARN_VERSION}" >&2
  yarn set version ${YARN_VERSION}
fi

YARN_CONFIG_FILE="${HOME_DIR}/.yarnrc.yml"
if [ -f "$YARN_CONFIG_FILE" ]; then
  echo "skip yarn config file creation" >&2
else
  echo "nodeLinker: node-modules" > "$YARN_CONFIG_FILE"
fi

echo "-- completed --" >&2
echo "" >&2
