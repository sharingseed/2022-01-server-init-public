set -eu
echo "-- $(basename $(dirname $0))/$(basename $0) --" >&2

# Install unzip
if [ -x "$(command -v unzip)" ]; then
  echo "skip install unzip" >&2
else
  sudo apt-get install -y unzip
fi

# Install tfenv
if [ -e "/usr/lib/tfenv" ]; then
  echo "skip download tfenv" >&2
else
  sudo git clone https://github.com/tfutils/tfenv.git /usr/lib/tfenv
  sudo chown ${USER} -R /usr/lib/tfenv
fi
if [ -x "$(command -v tfenv)" ]; then
  echo "skip install tfenv" >&2
else
  sudo ln -s /usr/lib/tfenv/bin/tfenv /usr/local/bin/tfenv
fi
if [ -x "$(command -v terraform)" ]; then
  echo "skip install terraform" >&2
else
  sudo ln -s /usr/lib/tfenv/bin/terraform /usr/local/bin/terraform
fi

# Install terraform
tfenv install

echo "-- completed --" >&2
echo "" >&2
