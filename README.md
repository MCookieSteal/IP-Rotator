# Rotación de IPs con Tor

Este es un script en Python que utiliza la librería stem para establecer una conexión con Tor y rotar las direcciones IP de manera programática. El objetivo es cambiar las direcciones IP para evitar el bloqueo o el rastreo en la web. Mediante Tor conseguiremos ir saltando de IP, y mediante FoxyProxy nos conectaremos al proxy creado en local para salir a internet. Es imnportante decir que este codigo esta pensado para Linux, pero con algunos cambios podria ser util en Windows.
## Requerimientos

Este script requiere la instalación previa de Tor y de FoxyProxy, ya que es sencillo de utilizar (es un addon que hay que instalar en nuestro navegador). Ademas, del script.

## Instalación

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
 Una vez tengamos hecho los cambios, vamos a reiniciamos el servicio de Tor:
 
``` 
sudo service tor restart   
```

Ahora ya solo nos quedara configurar FoxyProxy, poniendo la IP "127.0.0.1" y el puerto "8118" y poner en el codigo, la contraseña que hemos creado antes con Tor(en texto claro).

```
controller.authenticate(password='AQUI_LA_CONTRASEÑA')
```

Ahora ya solo nos quedara disfrutar de nuestro codigo ejecutando:

```
python rotado_IP.py
```


## Personalización

Puedes personalizar el tiempo de espera entre rotaciones de IP cambiando el valor del parámetro time.sleep() en el loop principal del script. Se recomienda dejarlo en 10 ya que Tor, no es capaz de rotar las IPs mas rapido.

## Capturas de uso


## Aviso legal

El uso de este script es responsabilidad del usuario. Por favor, asegúrate de utilizarlo de forma ética y legal.
