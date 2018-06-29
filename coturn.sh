#!/bin/sh

if case "$1" in -*) false;; *) true;; esac && which "$1" &> /dev/null; then
    echo "Executing $@"
    exec "$@"
fi

if ! [ -e "/etc/coturn/turnserver.conf" ]; then
    [ -n "$EXTERNAL_IP" ] || { echo "Missing EXTERNAL_IP env variable, please provide a /etc/coturn/turnserver.conf or provide external IP through environment."; exit 1; }
fi

if [ -n "$EXTERNAL_IP" ]; then
    if [ -n "$INTERNAL_IP" ]; then
        echo "external-ip=$EXTERNAL_IP/$INTERNAL_IP" >> /etc/coturn/turnserver-extra.conf
    else
        echo "external-ip=$EXTERNAL_IP" >> /etc/coturn/turnserver-extra.conf
    fi
fi

[ -n "$PORT" ] && echo "listening-port=$PORT" >> /etc/coturn/turnserver-extra.conf
[ -n "$MIN_PORT" ] && echo "min-port=$MIN_PORT" >> /etc/coturn/turnserver-extra.conf
[ -n "$MAX_PORT" ] && echo "max-port=$MAX_PORT" >> /etc/coturn/turnserver-extra.conf

if [ -n "$AUTH_SECRET" ]; then
    cat <<EOF >> /etc/coturn/turnserver-extra.conf
lt-cred-mech
use-auth-secret
static-auth-secret=$AUTH_SECRET
EOF
fi

[ -n "$REALM" ] && echo "realm=$REALM" >> /etc/coturn/turnserver-extra.conf

[ -n "$EXTRA_CONFIG" ] && echo "$EXTRA_CONFIG" >> /etc/coturn/turnserver-extra.conf

# Expand shell variables in config
[ -e '/etc/coturn/turnserver.conf' ] && shell-expand /etc/coturn/turnserver.conf /tmp/turnserver.conf
shell-expand /etc/coturn/turnserver-extra.conf /tmp/turnserver.conf

turnserver -c /tmp/turnserver.conf "$@"
