# platform = multi_platform_sle,multi_platform_slmicro

{{{ bash_instantiate_variables("var_password_pam_tally2") }}}

# Configurar el deny limit sin afectar a root
{{{ bash_ensure_pam_module_option('/etc/pam.d/login', 'auth', 'required', 'pam_tally2.so', 'deny', "${var_password_pam_tally2}", '') }}}

# Asegurar que el módulo está registrado en common-account
{{{ bash_ensure_pam_module_option('/etc/pam.d/common-account', 'account', 'required', 'pam_tally2.so', '', '', '') }}}
