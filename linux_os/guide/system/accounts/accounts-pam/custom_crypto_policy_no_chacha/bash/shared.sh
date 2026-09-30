# platform = multi_platform_all

# Crear el directorio por si no existe
mkdir -p /etc/crypto-policies/policies/modules

# Crear el archivo con la restricción del cipher
echo "cipher@ssh = -CHACHA20-POLY1305" > /etc/crypto-policies/policies/modules/NO-CHACHA.pmod

# Aplicar la política
update-crypto-policies --set DEFAULT:NO-CHACHA
