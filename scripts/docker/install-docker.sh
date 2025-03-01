set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install docker
if [ -x "$(command -v docker)" ]; then
  echo "skip install docker" >&2
else
  # Install Docker
  curl -fsSL get.docker.com | sudo sh
fi

# Start docker
sudo service docker start

# Enable docker
if [ "$(sudo systemctl is-enabled docker)" = "enabled" ]; then
  echo "skip enable docker" >&2
else
  sudo systemctl enable docker
fi

# Permit for dev user
if groups $USER | grep -q "docker"; then
  echo "skip set docker-group to current-user" >&2
else
  sudo usermod -aG docker $USER
  echo "* 'newgrp docker' to use docker command in the place."
fi

echo "-- completed --" >&2
echo "" >&2
