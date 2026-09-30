# platform = multi_platform_all

CIPHERS="aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"

# 1. Modificar /etc/ssh/sshd_config
if grep -qi "^Ciphers" /etc/ssh/sshd_config; then
    sed -i "s/^Ciphers.*/Ciphers $CIPHERS/" /etc/ssh/sshd_config
else
    echo "Ciphers $CIPHERS" >> /etc/ssh/sshd_config
fi

# 2. Modificar /etc/ssh/sshd_config.d/ (Creando un drop-in específico)
mkdir -p /etc/ssh/sshd_config.d
echo "Ciphers $CIPHERS" > /etc/ssh/sshd_config.d/01-custom-ciphers.conf

# 3. Modificar explícitamente el back-end de crypto-policies
BACKEND="/etc/crypto-policies/back-ends/opensshserver.config"
if [ -f "$BACKEND" ]; then
    if grep -qi "^Ciphers" "$BACKEND"; then
        sed -i "s/^Ciphers.*/Ciphers $CIPHERS/" "$BACKEND"
    else
        echo "Ciphers $CIPHERS" >> "$BACKEND"
    fi
fi

exit 0
