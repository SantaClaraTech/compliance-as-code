# platform = multi_platform_all
find /var/log -regextype posix-extended -type f -regex '^/var/log/(chrony/.*|cups/.*|httpd/.*|samba/.*|nginx/.*|dnf.*|hawkey.*|tuned/.*|rhsm/.*|qemu-ga/.*)$' -exec chmod 0640 {} + 2>/dev/null
