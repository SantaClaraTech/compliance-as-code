# platform = multi_platform_all
find /var/log -regextype posix-extended -type f -regex '^/var/log/(messages.*|cron.*|maillog.*|boot\.log.*|spooler.*|dmesg.*|firewalld.*|syslog.*)$' -exec chmod 0640 {} + 2>/dev/null
