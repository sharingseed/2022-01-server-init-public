```.env
VPN_USER=********
VPN_PASSWORD=********
VPN_URL=https://********
SOCKS5_PORT=8022
```

```sh
# start
docker compose up -d

# test proxy
curl --proxy 'socks5h://127.0.0.1:8022' 'https://api.ipify.org/'
ssh -o ProxyCommand='nc -x 127.0.0.1:8022 %h %p' user@host

# reload danted
docker compose exec openconnect bash -c "
cat /etc/_danted.conf > /etc/danted.conf
service danted restart
"
```
