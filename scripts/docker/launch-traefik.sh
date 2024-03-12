set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Create bridge network
if [ -n "$(docker network ls --filter name=intr -q)" ]; then
  echo "skip create network intr" >&2
else
  docker network create intr
fi

DOCKER_COMPOSE_FILE="$(cd $(dirname $0); pwd)/../../assets/traefik/docker-compose.yml"

# Launch traefik
echo $DOCKER_COMPOSE_FILE
docker compose -p traefik -f ${DOCKER_COMPOSE_FILE} up -d

echo "-- completed --" >&2
echo "" >&2
