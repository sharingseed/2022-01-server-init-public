set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Set default user.name
if [ -n "$(git config --global user.name)" ]; then
  echo "skip git-config global user.name" >&2
else
  git config --global user.name "${GIT_USER_NAME:-Noname}"
fi

# Set default user.email
if [ -n "$(git config --global user.email)" ]; then
  echo "skip git-config global user.email" >&2
else
  git config --global user.email "${GIT_USER_EMAIL:-noname@localhost}"
fi

echo "-- completed --" >&2
echo "" >&2
