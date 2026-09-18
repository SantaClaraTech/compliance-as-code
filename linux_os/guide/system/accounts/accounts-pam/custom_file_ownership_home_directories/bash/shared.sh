# platform = multi_platform_all
awk -F':' '{ if (($3 >= {{{ uid_min }}} && $3 != {{{ nobody_uid }}}) || $3 == 0) print $3 ":" $6 }' /etc/passwd | while IFS=':' read -r uid homedir; do
    if [ -d "$homedir" ]; then
        chown -f "$uid" "$homedir" || true
    fi
done || true

exit 0
