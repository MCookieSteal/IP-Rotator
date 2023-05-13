# Rotating IPs with Tor

This is a Python script that uses the stem library to establish a connection with Tor and rotate IP addresses programmatically. The goal is to change IP addresses to avoid blocking or tracking on the web. Through Tor, we can jump from one IP address to another, and through FoxyProxy, we will connect to the proxy created locally to access the internet. It is important to note that this code is intended for Linux, but with some changes, it could be useful on Windows.
## Requirements

This script requires the prior installation of Tor and FoxyProxy, which is easy to use _(it's a browser addon that needs to be installed)_. In addition, the script requires the following:
```
FoxyProxy Mozilla: https://addons.mozilla.org/es/firefox/addon/foxyproxy-standard/
FoxyProxy Chrome: https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp
```
## Installation

The first step to make everything work correctly is to download Tor. Once we have downloaded Tor, the first thing we will do is create a hash using a password that we choose, with the following command:
```
tor --hash-password <password>
```
This will give us a hash that we will have to paste into our configuration file. Then, we will go to the configuration file located at _"/etc/tor/torrc"_ with a text editor, and modify the following lines that will be commented out _(delete "#")_ :

```
ControlPort 9051
HashedControlPassword <<Here we will put our hashed password>>
CookieAuthentication 1
```
Once we have made the changes, we will restart the Tor service:
```
sudo service tor restart   
```
Now we just have to configure FoxyProxy, by putting the IP "127.0.0.1" and port "8118", and entering the password we created earlier with Tor _(in plain text)_ into the code:
```
controller.authenticate(password='HERE_THE_PASSWORD')
```
Now we just have to enjoy our code by running:
```
python IP_rotator.py
```
## Images

As we can see in the following images, this would be the configuration of FoxyProxy and this would be the operation of the IP rotator. One website to check if your IP is rotating correctly is, but it is important to know that you have to close and reopen the browser to see the change, due to cookie issues:
```
http://icanhazip.com/
curl --proxy http://127.0.0.1:8118 http://icanhazip.com/ 
```

![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/FoxyProxy.PNG?raw=true)
![](https://github.com/aldekoa15/IP-Rotator/blob/main/Images/Example.PNG?raw=true)

## Customization

You can customize the wait time between IP rotations by changing the value of the time.sleep() parameter in the main loop of the script. It is recommended to leave it at 10 since Tor is not able to rotate IPs faster.
## Legal notice

The use of this script is the responsibility of the user. Please make sure to use it ethically and legally.


___________________________________________________________________________________________________________________________________________________________________


# Rotación de IPs con Tor

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
