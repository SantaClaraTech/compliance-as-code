# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

{{{ bash_instantiate_variables("var_password_pam_minlen") }}}

PWQUALITY_CONF="/etc/security/pwquality.conf"

# 1. Configurar 'minlen' en /etc/security/pwquality.conf
if grep -qE '^\s*#?\s*minlen\s*=' "$PWQUALITY_CONF"; then
    sed -i -E "s/^\s*#?\s*minlen\s*=.*/minlen = $var_password_pam_minlen/" "$PWQUALITY_CONF"
else
    echo "minlen = $var_password_pam_minlen" >> "$PWQUALITY_CONF"
fi

# 2. Eliminar 'minlen=X' de los archivos PAM
for pam_file in /etc/pam.d/system-auth /etc/pam.d/password-auth; do
    if [ -f "$pam_file" ]; then
        sed -i -E 's/(^\s*password\s+.*pam_pwquality\.so.*)(\s+minlen=[0-9]+)(.*$)/\1\3/' "$pam_file"
    fi
done
