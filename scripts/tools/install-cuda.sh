set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install cuda
if [ -x "$(command -v nvidia-smi)" ]; then
  echo "skip install cuda" >&2
else
  # Select from https://developer.nvidia.com/cuda-downloads
  DL_URL=${1:-https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb}
  wget -O /tmp/cuda-keyring.deb "${DL_URL}"
  sudo dpkg -i /tmp/cuda-keyring.deb
  sudo apt-get update
  sudo apt-get -y install cuda
fi

# Check GPU
nvidia-smi -L

echo "-- completed --" >&2
echo "" >&2

