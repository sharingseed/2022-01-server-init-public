set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Watch files limit
if grep -q "fs.inotify.max_user_watches=524288" "/etc/sysctl.conf"; then
  echo "skip set fs.inotify.max_user_watches" >&2
else
  sudo sed -i -e 's/fs.inotify.max_user_watches=.*//' "/etc/sysctl.conf"
  echo "fs.inotify.max_user_watches=524288" | sudo tee -a "/etc/sysctl.conf"
  sudo sysctl -p
fi

echo "-- completed --" >&2
echo "" >&2
