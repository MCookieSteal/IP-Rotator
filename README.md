# Rotación de IPs con Tor

Este es un script en Python que utiliza la librería stem para establecer una conexión con Tor y rotar las direcciones IP de manera programática. El objetivo es cambiar las direcciones IP para evitar el bloqueo o el rastreo en la web. Mediante Tor conseguiremos ir saltando de IP, y mediante FoxyProxy nos conectaremos al proxy creado en local para salir a internet. Es imnportante decir que este codigo esta pensado para Linux, pero con algunos cambios podria ser util en Windows.
## Requerimientos

Este script requiere la instalación previa de Tor y de FoxyProxy, ya que es sencillo de utilizar. Ademas, de el script.

##Instalación

El primer paso para que todo fincione correctamentre, es descargarnos Tor. Una vez tengamos descargado Tor, lo primero que haremos es crear un hash mediante una contraseña que nosotros eligamos, con el comando siguiente:

``` 
tor --hash-password <password>
```

Eso nos dara un hash que tendremos que pegar en nuestro archivo de configuracion. Despues, iremos al archivo de configuracion situado en "/etc/tor/torrc" con un editor de texto, y modificaremos las siguientes lines que estaran comentadas (borrar "#"):

```
ControlPort 9051
HashedControlPassword <<Aqui pondremos nuestra contraseña hasheada>>
CookieAuthentication 1
```

## Uso

Para usar este script, simplemente ejecútalo en tu terminal:

```python rotado_IP.py```

El script se ejecutará en un loop infinito, rotando las direcciones IP cada 10 segundos.
## Personalización

Puedes personalizar el tiempo de espera entre rotaciones de IP cambiando el valor del parámetro time.sleep() en el loop principal del script.

También puedes modificar la dirección IP del proxy Tor, que por defecto está en 127.0.0.1:9050. Para ello, debes cambiar las variables socks.setdefaultproxy() y controller.from_port().
## Aviso legal

El uso de este script es responsabilidad del usuario. Por favor, asegúrate de utilizarlo de forma ética y legal.
