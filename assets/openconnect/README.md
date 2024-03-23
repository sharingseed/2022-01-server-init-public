```sh
cp .env.example .env
cp _danted.conf.example _danted.conf

# start
docker compose up -d

# test proxy on proxy-server
curl --proxy 'socks5h://127.0.0.1:8022' 'https://api.ipify.org/'

# use proxy-server via port-forward
ssh -L8222:socks-server:8022 proxy
ssh -o ProxyCommand='nc -x 127.0.0.1:8222 %h %p' user@host
curl --proxy 'socks5h://127.0.0.1:8222' 'https://api.ipify.org/'

# reload danted config
docker compose exec openconnect bash /init.sh _start_proxy
```
