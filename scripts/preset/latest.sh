set -eu
# Usage:
# BASE_URL="example.com" bash scripts/preset/latest.sh

LIB_DIR=$(cd $(dirname $0)/..; pwd)

bash "${LIB_DIR}/os/set-max-user-watches.sh"
bash "${LIB_DIR}/os/add-swap-1.sh"
bash "${LIB_DIR}/os/set-base-url.sh"
bash "${LIB_DIR}/os/set-needrestart.sh"

bash "${LIB_DIR}/tools/install-anyenv.sh"
bash "${LIB_DIR}/tools/install-jq.sh"
bash "${LIB_DIR}/tools/install-yq.sh"
bash "${LIB_DIR}/tools/set-git-default-user.sh"

bash "${LIB_DIR}/docker/install-docker.sh"
bash "${LIB_DIR}/docker/install-docker-compose.sh"
bash "${LIB_DIR}/docker/launch-traefik.sh"

bash "${LIB_DIR}/node/install-nodenv.sh"
bash "${LIB_DIR}/node/install-node.sh" "18.17.0"
bash "${LIB_DIR}/node/install-npm-global.sh" "yarn"

bash "${LIB_DIR}/python/install-pyenv.sh"
bash "${LIB_DIR}/python/install-python.sh" "3.11.4"
bash "${LIB_DIR}/python/install-poetry.sh"

bash "${LIB_DIR}/php/install-phpenv.sh"
bash "${LIB_DIR}/php/install-php.sh" "8.1.5"
bash "${LIB_DIR}/php/install-composer.sh"

echo "-- completed all --" >&2

