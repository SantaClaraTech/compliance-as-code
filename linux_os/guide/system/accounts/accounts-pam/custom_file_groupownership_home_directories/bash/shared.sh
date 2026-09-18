# platform = multi_platform_all
awk -F':' '{ if (($3 >= {{{ uid_min }}} && $3 != {{{ nobody_uid }}}) || $3 == 0) print $4 ":" $6 }' /etc/passwd | while IFS=':' read -r gid homedir; do
    if [ -d "$homedir" ]; then
        chgrp -f "$gid" "$homedir" || true
    fi
done || true

exit 0
