set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

if [ -e "/etc/needrestart/conf.d/" ]; then
  if [ ! -e "/etc/needrestart/conf.d/50local.conf" ]; then
    echo "\$nrconf{restart} = 'a';" \
      | sudo tee "/etc/needrestart/conf.d/50local.conf"
  fi
fi

echo "-- completed --" >&2
echo "" >&2
