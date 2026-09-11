documentation_complete: true

title: 'Perfil CIS_RSI'

description: |-
    Perfil de bastionado CIS_RSI. Contiene el conjunto de reglas de seguridad 
    requeridas para el bastionado de las máquinas, incluyendo configuraciones de 
    particiones, permisos de GRUB, parámetros del kernel, cron, gestión de 
    usuarios y desactivación de servicios innecesarios.

selections:
    # --- Particiones y Montajes ---
    - partition_for_tmp
    - mount_option_tmp_nodev
    - mount_option_tmp_nosuid
    - mount_option_tmp_noexec

    # --- Permisos de Arranque (GRUB2) ---
    #- file_permissions_boot_grub2_cfg
    #- file_owner_boot_grub2_cfg
    #- file_groupowner_boot_grub2_cfg
    - file_groupowner_grub2_cfg
    - file_groupowner_user_cfg
    - file_groupowner_user_cfg_grubenv
    - file_owner_grub2_cfg
    - file_owner_user_cfg
    - file_owner_user_cfg_grubenv
    - file_permissions_grub2_cfg
    - file_permissions_user_cfg
    - file_permissions_user_cfg_grubenv
    - file_permissions_efi_grub2_cfg_rsi
    - file_groupowner_efi_grub2_cfg
    - file_owner_efi_grub2_cfg

    # --- Parámetros del Kernel (Sysctl) ---
    - sysctl_kernel_randomize_va_space
    - sysctl_net_ipv4_tcp_syncookies
    - sysctl_net_ipv4_icmp_ignore_bogus_error_responses
    - sysctl_net_ipv4_conf_all_secure_redirects
    - sysctl_net_ipv4_conf_default_secure_redirects

    # --- Mensaje de Bienvenida ---
    - file_permissions_etc_motd
    - file_groupowner_etc_motd
    - file_owner_etc_motd

    # --- Servicios ---
    - service_bluetooth_disabled
    - service_bluetooth_removed

    # --- Tareas Programadas (Cron) ---
    - file_permissions_crontab
    - file_groupowner_crontab
    - file_owner_crontab
    - file_permissions_cron_hourly
    - file_groupowner_cron_hourly
    - file_owner_cron_hourly
    - file_permissions_cron_weekly
    - file_groupowner_cron_weekly
    - file_owner_cron_weekly
    - file_permissions_cron_monthly
    - file_groupowner_cron_monthly
    - file_owner_cron_monthly

    # --- Logs y Auditoría ---
    - rsyslog_remote_loghost
    #- rsyslog_remote_tls  ---- esta regla no interfiere en el bastionado pedido ----
    #- rsyslog_remote_tls_cacert  --- esta regla no interfiere en el bastionado pedido ----

    # --- Gestión de Cuentas y Usuarios ---
    - accounts_maximum_age_login_defs
    - var_accounts_maximum_age_login_defs=90
    - accounts_user_interactive_home_directory_exists
    - file_ownership_home_directories
    - file_permissions_home_directories
    - accounts_user_dot_group_ownership
    - accounts_user_dot_no_world_writable_programs
    - accounts_user_dot_user_ownership
    # ------ultimas añadidas recientemente--------
    - no_rhost_files
    - no_forward_files
    - accounts_users_netrc_file_permissions
    - file_permission_user_bash_history
    - file_permission_all_dot

