
# Docu

## Requisitos previos

Servidor Principal:

- Ubuntu 24
- Nombre DNS: master.j-cloud.com.mx

Servidores deploy:

- Ubuntu 24

Copia de claves SSH a máquinas administradas

La comunicación entre la máquina de control y las administradas es vía SSH. Por tanto, la máquina de control deberá tener la clave privada y las máquinas administradas la clave pública (examinar el archivo ~/.ssh/authorized_keys de las máquinas administradas para ver las claves públicas autorizadas).

Para ello, copiaremos la clave desde la máquina de control hasta las máquinas administradas con ssh-copy-id.

> Nota: La máquna de control es aquella desde donde se lanza Ansible y no necesariamente son las máquinas de destino.

Por ejemplo:

```bash
ssh-copy-id -i ~/.ssh/id_rsa 20.0.0.27
ssh-copy-id -i ~/.ssh/id_rsa 20.0.0.22
```

## Definir el Branding

Para definir un branding visita el sitio [Generador de branding](https://www.hubspot.es/brand-kit-generator/thank-you)

> Usa un 10 muntes mail para usar un email temporal

## Links

[Generador de branding](https://www.hubspot.es/brand-kit-generator/thank-you)
