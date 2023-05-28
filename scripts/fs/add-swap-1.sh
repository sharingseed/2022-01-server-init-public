set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Add swap 1
if [ -e "/swapfile1" ]; then
  echo "skip add swap 1" >&2
else
  # Mount swap
  sudo dd if=/dev/zero of=/swapfile1 bs=1M count=4096
  sudo chmod 600 /swapfile1
  sudo mkswap /swapfile1
  sudo swapon /swapfile1
  sudo swapon -s
  sudo cp -p /etc/fstab /etc/fstab_$(date "+%Y%m%d-%H%M%S")
  echo "/swapfile1 swap swap defaults 0 0" | sudo tee -a /etc/fstab
  sudo mount -a
fi

echo "-- completed --" >&2
echo "" >&2
