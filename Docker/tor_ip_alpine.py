import os
import signal
import sys
import time
import socket
import socks
import subprocess
import requests
from stem import Signal
from stem.control import Controller

resultado = subprocess.Popen("tor -f /etc/tor/torrc-instance0 & tor -f /etc/tor/torrc-instance1 & tor -f /etc/tor/torrc-instance2 & tor -f /etc/tor/torrc-instance3 & tor -f /etc/tor/torrc-instance4 & tor -f /etc/tor/torrc-instance5 & tor -f /etc/tor/torrc-instance6 & tor -f /etc/tor/torrc-instance7 & tor -f /etc/tor/torrc-instance8 && haproxy -f /etc/haproxy/haproxy.cfg", shell=True, text=True)
resultado = subprocess.run("haproxy -f /etc/haproxy/haproxy.cfg", shell=True, capture_output=True, text=True)
time.sleep(8)

controller0 = Controller.from_port(port=9051)
controller1 = Controller.from_port(port=9151)
controller2 = Controller.from_port(port=9251)
controller3 = Controller.from_port(port=9351)
controller4 = Controller.from_port(port=9451)
controller5 = Controller.from_port(port=9551)
controller6 = Controller.from_port(port=9651)
controller7 = Controller.from_port(port=9751)
controller8 = Controller.from_port(port=9851)
port = 9050
i = 0

def signal_handler(sig, frame):
    print("Programa detenido")
    resultado = subprocess.run("killall tor", shell=True, capture_output=True, text=True)
    sys.exit(0)

def connectTor(port):
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5 , "127.0.0.1", port, True)
    socket.socket = socks.socksocket

def renew_tor():
    controller0.authenticate(password='ksdjfhskdjfhskdjfh')
    controller0.signal(Signal.NEWNYM)
    controller1.authenticate(password='ksdjfhskdjfhskdjfh')
    controller1.signal(Signal.NEWNYM)
    controller2.authenticate(password='ksdjfhskdjfhskdjfh')
    controller2.signal(Signal.NEWNYM)
    controller3.authenticate(password='ksdjfhskdjfhskdjfh')
    controller3.signal(Signal.NEWNYM)
    controller4.authenticate(password='ksdjfhskdjfhskdjfh')
    controller4.signal(Signal.NEWNYM)
    controller5.authenticate(password='ksdjfhskdjfhskdjfh')
    controller5.signal(Signal.NEWNYM)
    controller6.authenticate(password='ksdjfhskdjfhskdjfh')
    controller6.signal(Signal.NEWNYM)
    controller7.authenticate(password='ksdjfhskdjfhskdjfh')
    controller7.signal(Signal.NEWNYM)
    controller8.authenticate(password='ksdjfhskdjfhskdjfh')
    controller8.signal(Signal.NEWNYM)

def show_my_ip():
    resultado = subprocess.run("curl --socks5 127.0.0.1:8811 http://icanhazip.com/ -s", shell=True, capture_output=False, text=True)


while True:
    renew_tor()
    connectTor(port)
    if i == 0:
      port = 9050
    elif i == 1:
      port = 9150
    elif i == 2:
      port = 9250
    elif i == 3:
      port = 9350
    elif i == 4:
      port = 9450
    elif i == 5:
      port = 9550
    elif i == 6:
      port = 9650
    elif i == 7:
      port = 9750
    else:
      port = 9850
      i = 0
    i = i + 1
    show_my_ip()
    time.sleep(3)
    signal.signal(signal.SIGINT, signal_handler)
