#!/usr/bin/env bash
# platform = multi_platform_all

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs 2>/dev/null)
[ -z "$UID_MIN" ] && UID_MIN=1000
FAIL=0

check_file() {
    local file="$1"
    local exp_user="$2"
    local exp_group="$3"

    curr_user=$(stat -c "%U" "$file" 2>/dev/null)
    curr_group=$(stat -c "%G" "$file" 2>/dev/null)

    # Validar Propietario
    if [[ "$exp_user" == *"|"* ]]; then
        if ! echo "$curr_user" | grep -Eq "^($exp_user)$" ; then
            FAIL=1
        fi
    else
        if [ "$curr_user" != "$exp_user" ]; then
            FAIL=1
        fi
    fi

    # Validar Grupo
    if [[ "$exp_group" == *"|"* ]]; then
        if ! echo "$curr_group" | grep -Eq "^($exp_group)$" ; then
            FAIL=1
        fi
    else
        if [ "$curr_group" != "$exp_group" ]; then
            FAIL=1
        fi
    fi
}

# Búsqueda segura con soporte para espacios en nombres de archivo
while IFS= read -r -d '' file; do
    bname=$(basename "$file")
    case "$bname" in
        wtmp|btmp|lastlog) check_file "$file" "root" "root|utmp" ;;
        secure|auth.log|syslog) check_file "$file" "root|syslog" "root|adm" ;;
        *sssd*) check_file "$file" "root|sssd" "root|sssd" ;;
        *.journal) check_file "$file" "root" "root|systemd-journal" ;;
        *)
            curr_uid=$(stat -c "%u" "$file" 2>/dev/null)
            curr_user=$(stat -c "%U" "$file" 2>/dev/null)
            if [ -n "$curr_uid" ] && [ "$curr_uid" -lt "$UID_MIN" ] && [ "$curr_user" != "root" ]; then
                target_user="$curr_user"
            else
                target_user="root"
            fi
            check_file "$file" "$target_user" "root|adm"
            ;;
    esac
done < <(find /var/log -type f -print0)

# Retornar los códigos nativos del framework
if [ "$FAIL" -eq 0 ]; then
    exit "${XCCDF_RESULT_PASS:-0}"
else
    exit "${XCCDF_RESULT_FAIL:-1}"
fi
