#!/bin/bash

mv /etc/privoxy/config.new /etc/privoxy/config
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

cat << EOF > /etc/haproxy/haproxy.cfg
global
#---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   http://haproxy.1wt.eu/download/1.5/doc/configuration.txt
#
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the --r- option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

#---------------------------------------------------------------------
# common defaults that all the -listen- and -backend- sections will
# use if not designated in their block
#---------------------------------------------------------------------

defaults
        log     global
        mode    http
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000

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

mkdir /var/lib/tor/instance0 /var/lib/tor/instance1 /var/lib/tor/instance2 /var/lib/tor/instance3 /var/lib/tor/instance4 /var/lib/tor/instance5 /var/lib/tor/instance6 /var/lib/tor/instance7 /var/lib/tor/instance8

hashed_password=$(tor --hash-password "ksdjfhskdjfhskdjfh" 2>&1 | awk '/^16:/ {print $0}' )

# Definir el contenido del primer archivo
file_content="Log notice file /var/log/tor/notices.log
SocksPort 9050
ControlPort 9051
DataDirectory /var/lib/tor/instance0
HashedControlPassword $hashed_password
CookieAuthentication 1"

# Crear el primer archivo
echo "$file_content" > torrc-instance0


# Crear los siguientes seis archivos con contenido similar
for i in {1..8}
do
    echo "$file_content" | sed -e "s/9050/9${i}50/g" -e "s/9051/9${i}51/g" -e "s/instance0/instance$i/g" -e "s/16:HAS_HERE/$hashed_password/g" > "torrc-instance$i"
done

mv torrc-instance0 /etc/tor/ && mv torrc-instance1 /etc/tor/ && mv torrc-instance2 /etc/tor/ && mv torrc-instance3 /etc/tor/ && mv torrc-instance4 /etc/tor/ && mv torrc-instance5 /etc/tor/ && mv torrc-instance6 /etc/tor/ && mv torrc-instance7 /etc/tor/ && mv torrc-instance8 /etc/tor/
