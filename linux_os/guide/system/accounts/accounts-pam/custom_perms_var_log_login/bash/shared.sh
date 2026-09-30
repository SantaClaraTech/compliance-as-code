# platform = multi_platform_all
find /var/log -regextype posix-extended -type f -regex '^/var/log/(secure.*|btmp.*|wtmp.*|tallylog.*|lastlog.*|audit/.*|sssd/.*)$' -exec chmod 0600 {} + 2>/dev/null
