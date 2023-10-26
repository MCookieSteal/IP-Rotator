#!/bin/bash

apt install haproxy privoxy tor >> basura.txt
echo "TOR, HAPROXY Y PRIVOXY --> instalado"
sleep 1
mv /etc/privoxy/config /etc/privoxy/config_backup1
touch /etc/privoxy/config
cat << EOF > /etc/privoxy/config
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
logdir /var/log/privoxy
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
listen-address 127.0.0.1:8118
forward-socks5 / 127.0.0.1:8811 .
EOF
echo "PRIVOXY configurado --> Archivo de configuracion creado --> /etc/privoxy/config"
systemctl restart privoxy.service
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy_backup.cfg
touch /etc/haproxy/haproxy.cfg
cat << EOF > /etc/haproxy/haproxy.cfg
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

frontend http_front
    bind *:8811
    mode tcp
    default_backend tor_backend

backend tor_backend
    mode tcp
    balance roundrobin
    server server1 127.0.0.1:9050 check
    server server2 127.0.0.1:9150 check
    server server3 127.0.0.1:9250 check
    server server4 127.0.0.1:9350 check
    server server5 127.0.0.1:9450 check
    server server6 127.0.0.1:9550 check
    server server7 127.0.0.1:9650 check
    server server8 127.0.0.1:9750 check
    server server9 127.0.0.1:9850 check
EOF
echo "HAPROXY configurado --> Archivo de configuracion creado --> /etc/haproxy/haproxy.cfg"
mkdir /var/lib/tor/instance0 /var/lib/tor/instance1 /var/lib/tor/instance2 /var/lib/tor/instance3 /var/lib/tor/instance4 /var/lib/tor/instance5 /var/lib/tor/instance6 /var/lib/tor/instance7 /var/lib/tor/instance8

# Definir el contenido del primer archivo
file_content="Log notice file /var/log/tor/notices.log
SocksPort 9050
ControlPort 9051
DataDirectory /var/lib/tor/instance0
HashedControlPassword 16:HAS_HERE
CookieAuthentication 1"

hashed_password=$(tor --hash-password "ksdjfhskdjfhskdjfh" 2>&1 | awk '/^16:/ {print $0}' )

# Crear el primer archivo
echo "$file_content" > torrc-instance0

# Crear los siguientes seis archivos con contenido similar
for i in {1..8}
do
    echo "$file_content" | sed -e "s/9050/90${i}0/g" -e "s/9051/90${i}1/g" -e "s/instance0/instance$i/g" -e "s/16:HAS_HERE/$hashed_password/g" > "torrc-instance$i"
done
mv torrc-instance0 /etc/tor/ & mv torrc-instance1 /etc/tor/ & mv torrc-instance2 /etc/tor/ & mv torrc-instance3 /etc/tor/ & mv torrc-instance4 /etc/tor/ & mv torrc-instance5 /etc/tor/ & mv torrc-instance6 /etc/tor/ & mv torrc-instance7 /etc/tor/ & mv torrc-instance8 /etc/tor/
echo "TOR configurado --> Archivo de configuracion creado --> /etc/tor/torrc"
pip install -r requirements.txt >> basura.txt
rm basura.txt
echo "Requirements --> Instalados"
echo "Instalacion terminada"
