
```sh
# start
docker compose up -d

# test proxy
curl --proxy 'socks5h://127.0.0.1:8022' 'https://api.ipify.org/'

# reload danted
docker compose exec openconnect bash -c "
cat /etc/_danted.conf > /etc/danted.conf
service danted restart
"

# add user
docker compose exec openconnect bash -c "
adduser --shell /sbin/nologin --gecos '' preview
echo 'preview:cftyuhbvg' | chpasswd
"
```
