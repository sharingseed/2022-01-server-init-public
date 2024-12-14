set -eu
# Usage:
# BASE_URL="example.com" bash scripts/preset/latest.sh

cd $(dirname $0)/../..

bash "scripts/os/set-max-user-watches.sh"
bash "scripts/os/add-swap-1.sh"
bash "scripts/os/set-base-url.sh"
bash "scripts/os/set-needrestart.sh"

bash "scripts/tools/install-anyenv.sh"
bash "scripts/tools/install-jq.sh"
bash "scripts/tools/install-yq.sh"
bash "scripts/tools/set-git-default-user.sh"

bash "scripts/docker/install-docker.sh"
bash "scripts/docker/launch-traefik.sh"

bash "scripts/node/install-nodenv.sh"
bash "scripts/node/install-node.sh" "22.12.0"
bash "scripts/node/install-npm-global.sh" "yarn"

# bash "scripts/python/install-pyenv.sh"
# bash "scripts/python/install-poetry.sh"
# bash "scripts/python/install-python.sh" "3.12"
bash "scripts/python/install-uv.sh"
bash "scripts/python/install-uv-python.sh" "3.13"

# bash "scripts/php/install-phpenv.sh"
bash "scripts/php/install-php.sh" "8.3"
bash "scripts/php/install-composer.sh"

echo "-- completed all --" >&2

