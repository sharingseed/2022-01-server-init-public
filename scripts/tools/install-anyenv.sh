set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install anyenv
if [ -e "/usr/lib/anyenv" ]; then
  echo "skip download anyenv" >&2
else
  sudo git clone https://github.com/riywo/anyenv /usr/lib/anyenv
  sudo chown ${USER} -R /usr/lib/anyenv
fi

if [ -e "/etc/profile.d/anyenv.sh" ]; then
  echo "skip add profile.d/anyenv.sh" >&2
else
  sudo tee /etc/profile.d/anyenv.sh <<'EOL'
# anyenv
if [ -d /usr/lib/anyenv ] ; then
  export PATH="/usr/lib/anyenv/bin:$PATH"
  export ANYENV_ROOT="/usr/lib/anyenv"
  eval "$(anyenv init - --no-rehash)"
fi
EOL
fi

FILE="/etc/bash.bashrc"
SCRIPT='. /etc/profile.d/anyenv.sh'
if [ -n "$(grep "${SCRIPT}" "${FILE}")" ]; then
  echo "skip append ${FILE}" >&2
else
  echo "${SCRIPT}" | sudo tee -a "${FILE}" >&2
fi

source /etc/profile.d/anyenv.sh

if [ ! -e "$HOME/.config/anyenv/anyenv-install" ]; then
  anyenv install --force-init
fi

echo "-- completed --" >&2
echo "" >&2
