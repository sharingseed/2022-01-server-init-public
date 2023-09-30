set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

source /etc/profile.d/anyenv.sh

# Install poetry
if [ -n "$(command -v poetry)" ]; then
  echo "skip install poetry" >&2
else
  curl -sSL https://install.python-poetry.org | python3
fi

# Install poetry
SCRIPT_FILE="/etc/profile.d/set_user_path.sh"
if [ -e $SCRIPT_FILE ]; then
  echo "skip create '$SCRIPT_FILE'" >&2
else
  echo "PATH=\$HOME/.local/bin:\$PATH" | sudo tee $SCRIPT_FILE
  source $SCRIPT_FILE
fi

echo "-- completed --" >&2
echo "" >&2

