# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

# Eliminar minclass, dcredit, lcredit, ocredit y ucredit de los archivos PAM
for pam_file in /etc/pam.d/system-auth /etc/pam.d/password-auth; do
    if [ -f "$pam_file" ]; then
        # Localiza la línea de pam_pwquality.so y borra los parámetros especificados
        sed -i -E '/pam_pwquality\.so/ s/\s+(minclass|dcredit|lcredit|ocredit|ucredit)=[-0-9]+//g' "$pam_file"
    fi
done
