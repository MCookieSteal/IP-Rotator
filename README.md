# Rotación de IPs con Tor

Este es un script en Python que utiliza la librería Stem para establecer una conexión con Tor y rotar las direcciones IP de manera programática. El objetivo es cambiar las direcciones IP para evitar el bloqueo o el rastreo en la web y contra ataques a SSH, FTP... Mediante Tor conseguiremos ir saltando de IP, utilizando dos puertos diferentes, SOCKS5 en le puerto 8811 y HTTP en el 8118. Es importante decir que este código está pensado para Linux, pero con algunos cambios podría ser útil en Windows.

## Instalación

Lo primero que haremos es descargarnos las tres herramientas fundamentales que son _"tor, haproxy y privoxy"_, ya que necesitaremos las instancias de Tor, Haproxy para balancear las isntancias que levantemos (solo balancea SOCKS5) y Privoxy para poder usar HTTP (no es necesario). Con el archivo isntall.sh vamos a conseguir descargar y configurar las herramientas.
```
apt update & apt upgrade
./install.sh
```

Ahora ya solo nos quedará disfrutar de nuestro código ejecutando:

```
python tor_ip.py
```

Finalmente ya solo nos quedará configurar FoxyProxy, poniendo la IP _"127.0.0.1"_ y el puerto _"8118"_ si queremos usar http, pero en cambio para socks5 se utiliza el puerto _"8811"_.

```
curl http://127.0.0.1:8118 http://echoip.com
```

## Requerimientos

Este script requiere la instalación previa de Tor y de FoxyProxy para el uso del rotado en el navegador (HTTP), ya que es sencillo de utilizar _(es un add-on que hay que instalar en nuestro navegador)_. Además, del script.
```
FoxyProxy Mozilla: https://addons.mozilla.org/es/firefox/addon/foxyproxy-standard/
FoxyProxy Chrome: https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp
```

## Imágenes
Como podemos ver en las siguientes imágenes, esta sería la configuración de FoxyProxy y este sería el funcionamiento del rotador de IPs. Una página para ver si tu IP se está rotando de manera correcta es, pero es importante saber que hay que cerrar y abrir el navegador para ver el cambio, por temas de cookies...:

```
http://icanhazip.com/
curl --proxy http://127.0.0.1:8118 http://icanhazip.com/ 
```

![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/FoxyProxy.PNG?raw=true)
![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/Example.PNG?raw=true)


## Errores

Si por alguna razón, como la perdida de conexión a internet o cualquier otra circunstancia el código deja de funcionar/peta, es obligatorio ejecutar el siguiente comando para desactivar las instancias levantadas de Tor:

```
killall tor
```

## Aviso legal

El uso de este script es responsabilidad del usuario. Por favor, asegúrate de utilizarlo de forma ética y legal.
