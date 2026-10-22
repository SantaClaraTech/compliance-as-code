# platform = multi_platform_all

{{{ bash_instantiate_variables("var_accounts_tmout") }}}

# Archivos a limpiar
target_files="/etc/profile /etc/bashrc /etc/profile.d/*.sh"

# Comentar cualquier TMOUT activo en todos los archivos, EXCEPTO en nuestro timeout.sh
for f in $target_files; do
    if [ -f "$f" ] && [ "$f" != "/etc/profile.d/timeout.sh" ]; then
        if grep --silent '^[^#]*TMOUT' "$f"; then
            sed -i 's/^\([^#]*TMOUT\)/#\1/g' "$f"
        fi
    fi
done

# Crear el archivo maestro con el valor exacto
echo -e "# Enforced by CIS\ntypeset -xr TMOUT=$var_accounts_tmout" > /etc/profile.d/timeout.sh
