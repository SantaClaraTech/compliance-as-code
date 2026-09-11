# platform = multi_platform_sle,multi_platform_ubuntu,multi_platform_rhel
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

readarray -t interactive_users < <(awk -F: '$3>={{{ uid_min }}}   {print $1}' /etc/passwd)
readarray -t interactive_users_home < <(awk -F: '$3>={{{ uid_min }}}   {print $6}' /etc/passwd)
readarray -t interactive_users_shell < <(awk -F: '$3>={{{ uid_min }}}   {print $7}' /etc/passwd)

USERS_IGNORED_REGEX='nobody|nfsnobody'

for (( i=0; i<"${#interactive_users[@]}"; i++ )); do
    if ! grep -qP "$USERS_IGNORED_REGEX" <<< "${interactive_users[$i]}" && \
        [ "${interactive_users_shell[$i]}" != "/sbin/nologin" ]; then
        
        if [ -d "${interactive_users_home[$i]}" ]; then
            find -P "${interactive_users_home[$i]}" -maxdepth 1 -type f -name "\.[^.]*" -exec chmod u-sx,go-wx= "{}" \;
        fi
    fi
done
