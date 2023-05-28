set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

REPLACE_SHELL="sudo -u ${USER}"

# Create bridge network
if [ -n "$($REPLACE_SHELL docker network ls --filter name=intr -q)" ]; then
  echo "skip create network intr" >&2
else
  $REPLACE_SHELL docker network create intr
fi

DOCKER_COMPOSE_FILE="$(cd $(dirname $0); pwd)/../../assets/traefik2/docker-compose.yml"

# Launch traefik
$REPLACE_SHELL bash -c "
  source /etc/profile
  docker-compose -p traefik2 -f ${DOCKER_COMPOSE_FILE} up -d
"

echo "-- completed --" >&2
echo "" >&2
