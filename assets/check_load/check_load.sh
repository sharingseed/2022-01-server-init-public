set -eu

NOTIFY="2.5"
NUM="1" # 1: 1min, 2: 5min, 3: 15min

LOAD="$(uptime | awk -F "load average:" '{ print $2 }' | cut -d, -f$NUM | sed 's/ //g')"

if [ "$(echo "$LOAD > $NOTIFY" | bc)" == "1" ]; then
  echo "High: $LOAD"
else
  echo "Normal: $LOAD"
fi
