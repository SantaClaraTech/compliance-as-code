# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

{{{ bash_instantiate_variables("var_accounts_passwords_pam_faillock_unlock_time") }}}

FAILLOCK_CONF="/etc/security/faillock.conf"

# 1. Configurar 'unlock_time' en /etc/security/faillock.conf
if grep -qE '^\s*#?\s*unlock_time\s*=' "$FAILLOCK_CONF"; then
    sed -i -E "s/^\s*#?\s*unlock_time\s*=.*/unlock_time = $var_accounts_passwords_pam_faillock_unlock_time/" "$FAILLOCK_CONF"
else
    echo "unlock_time = $var_accounts_passwords_pam_faillock_unlock_time" >> "$FAILLOCK_CONF"
fi

# 2. Eliminar 'unlock_time=X' de los archivos PAM
for pam_file in /etc/pam.d/system-auth /etc/pam.d/password-auth; do
    if [ -f "$pam_file" ]; then
        sed -i -E 's/(^\s*auth\s+.*pam_faillock\.so.*)(\s+unlock_time=[0-9]+)(.*$)/\1\3/' "$pam_file"
    fi
done
