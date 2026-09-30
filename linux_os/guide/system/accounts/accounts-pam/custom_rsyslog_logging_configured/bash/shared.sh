# platform = multi_platform_all

mkdir -p /etc/rsyslog.d

cat << 'EOF' > /etc/rsyslog.d/99-cis-custom-logging.conf
mail.err                                /var/log/mail.err
local6,local7.*                         -/var/log/localmessages
auth,authpriv.*                         /var/log/secure
local2,local3.*                         -/var/log/localmessages
*.=warning;*.=err                       -/var/log/warn
*.emerg                                 :omusrmsg:*
mail.info                               -/var/log/mail.info
mail.*                                  -/var/log/mail
*.crit                                  /var/log/warn
cron.*                                  /var/log/cron
mail.warning                            -/var/log/mail.warn
*.*;mail.none;news.none                 -/var/log/messages
local4,local5.*                         -/var/log/localmessages
local0,local1.*                         -/var/log/localmessages
EOF

systemctl restart rsyslog
