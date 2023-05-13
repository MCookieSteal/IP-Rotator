# Rotación de IPs con Tor

Este es un script en Python que utiliza la librería stem para establecer una conexión con Tor y rotar las direcciones IP de manera programática. El objetivo es cambiar las direcciones IP para evitar el bloqueo o el rastreo en la web.
## Requerimientos

Este script requiere la instalación previa de Tor y la librería stem.
## Uso

Para usar este script, simplemente ejecútalo en tu terminal:

python rotado_IP.py

El script se ejecutará en un loop infinito, rotando las direcciones IP cada 10 segundos.
## Personalización

Puedes personalizar el tiempo de espera entre rotaciones de IP cambiando el valor del parámetro time.sleep() en el loop principal del script.

También puedes modificar la dirección IP del proxy Tor, que por defecto está en 127.0.0.1:9050. Para ello, debes cambiar las variables socks.setdefaultproxy() y controller.from_port().
## Aviso legal

El uso de este script es responsabilidad del usuario. Por favor, asegúrate de utilizarlo de forma ética y legal.
