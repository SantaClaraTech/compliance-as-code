# platform = multi_platform_sle,multi_platform_slmicro

# Eliminamos el enlace simbólico o archivo actual
unlink /etc/issue 2>/dev/null || rm -f /etc/issue 2>/dev/null || true

# Detenemos y deshabilitamos los servicios generadores de SUSE
systemctl stop issue-generator.path 2>/dev/null || true
systemctl disable issue-generator.path 2>/dev/null || true
systemctl stop issue-generator.service 2>/dev/null || true
systemctl disable issue-generator.service 2>/dev/null || true

# Creamos el nuevo archivo con el banner exacto de RSI
cat << 'EOF' > /etc/issue
Está terminantemente prohibido el acceso no autorizado a este sistema así como el uso indebido del mismo, conforme a la normativa de la compañía y la legislación vigente. Si entra en el sistema, admite conocer las políticas de seguridad de la compañía y da el consentimiento para que sus actividades sean monitorizadas.
La INFORMACION contenida en este servidor puede tener caracter CONFIDENCIAL o RESTRINGIDO según las políticas de seguridad de RSI, por lo que deberá CONOCER y APLICAR las medidas de seguridad correspondientes.
EOF
