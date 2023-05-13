# Corrección de errores de ortografía:
Rotación de IPs con Tor

Este es un script en Python que utiliza la librería Stem para establecer una conexión con Tor y rotar las direcciones IP de manera programática. El objetivo es cambiar las direcciones IP para evitar el bloqueo o el rastreo en la web. Mediante Tor conseguiremos ir saltando de IP, y mediante FoxyProxy nos conectaremos al proxy creado en local para salir a Internet. Es importante decir que este código está pensado para Linux, pero con algunos cambios podría ser útil en Windows.
## Requerimientos

Este script requiere la instalación previa de Tor y de FoxyProxy, ya que es sencillo de utilizar _(es un add-on que hay que instalar en nuestro navegador)_. Además, del script.
```
FoxyProxy Mozilla: https://addons.mozilla.org/es/firefox/addon/foxyproxy-standard/
FoxyProxy Chrome: https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp
```

## Instalación

El primer paso para que todo funcione correctamente es descargarnos Tor. Una vez tengamos descargado Tor, lo primero que haremos es crear un hash mediante una contraseña que nosotros elijamos, con el siguiente comando:

``` 
tor --hash-password <password>
```

Eso nos dará un hash que tendremos que pegar en nuestro archivo de configuración. Después, iremos al archivo de configuración situado en _"/etc/tor/torrc"_ con un editor de texto y modificaremos las siguientes líneas que estarán comentadas _(borrar "#")_:

```
ControlPort 9051
HashedControlPassword <<Aqui pondremos nuestra contraseña hasheada>>
CookieAuthentication 1
```
 Una vez tengamos hecho los cambios, vamos a reiniciar el servicio de Tor:
 
``` 
sudo service tor restart   
```

Ahora ya solo nos quedará configurar FoxyProxy, poniendo la IP _"127.0.0.1"_ y el puerto _"8118"_ y poner en el código la contraseña que hemos creado antes con Tor  _(en texto claro)_.

```
controller.authenticate(password='AQUI_LA_CONTRASEÑA')
```

Ahora ya solo nos quedará disfrutar de nuestro código ejecutando:

```
python IP_rotator.py
```
## Imágenes
Como podemos ver en las siguientes imágenes, esta sería la configuración de FoxyProxy y este sería el funcionamiento del rotador de IPs. Una página para ver si tu IP se está rotando de manera correcta es, pero es importante saber que hay que cerrar y abrir el navegador para ver el cambio, por temas de cookies...:

```
http://icanhazip.com/
curl --proxy http://127.0.0.1:8118 http://icanhazip.com/ 
```


![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/FoxyProxy.PNG?raw=true)
![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/Example.PNG?raw=true)


## Personalización

Puedes personalizar el tiempo de espera entre rotaciones de IP cambiando el valor del parámetro time.sleep() en el loop principal del script. Se recomienda dejarlo en 10 ya que Tor no es capaz de rotar las IPs más rápido.


## Aviso legal

El uso de este script es responsabilidad del usuario. Por favor, asegúrate de utilizarlo de forma ética y legal.
