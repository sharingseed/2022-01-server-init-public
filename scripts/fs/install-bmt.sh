set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

TARGET="/usr/local/bin/bmt"
SOURCE="$(cd $(dirname $0); pwd)/../../assets/bmt/bmt"
set +e
EFS_MOUNT=$(ls /mnt | grep -e "efs")
set -e

if [ -z "${EFS_MOUNT}" ]; then
  echo "skip install bmt, no /mnt/efs" >&2
elif [ -e "${TARGET}" ] && diff -q "${TARGET}" "${SOURCE}"; then
  echo "skip install bmt" >&2
else
  if [ -e "${TARGET}" ]; then
    sudo rm -f "${TARGET}"
  fi
  sudo cp "${SOURCE}" "${TARGET}"
  sudo chmod +x "${TARGET}"
fi

echo "-- completed --" >&2
echo "" >&2
