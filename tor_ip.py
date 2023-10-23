#!/usr/bin/env python
import signal
import sys
import time
import socket
import socks
import subprocess
import requests
from stem import Signal
from stem.control import Controller
from urllib.request import ProxyHandler, build_opener, install_opener

resultado = subprocess.Popen("tor -f /etc/tor/torrc-instance0 & tor -f /etc/tor/torrc-instance1 & tor -f /etc/tor/torrc-instance2 & tor -f /etc/tor/torrc-instance3 & tor -f /etc/tor/torrc-instance4 & tor -f /etc/tor/torrc-instance5 & tor -f /etc/tor/torrc-instance6 & tor -f /etc/tor/torrc-instance7 & tor -f /etc/tor/torrc-instance8", shell=True, text=True)
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

def _set_url_proxy():
    proxy_support = ProxyHandler({'http': '127.0.0.1:8118'})
    opener = build_opener(proxy_support)
    install_opener(opener)
_set_url_proxy()

def connectTor(port):
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5 , "127.0.0.1", port, True)
    socket.socket = socks.socksocket

def renew_tor():
    controller0.authenticate(password='PASS')
    controller0.signal(Signal.NEWNYM)
    controller1.authenticate(password='PASS')
    controller1.signal(Signal.NEWNYM)
    controller2.authenticate(password='PASS')
    controller2.signal(Signal.NEWNYM)
    controller3.authenticate(password='PASS')
    controller3.signal(Signal.NEWNYM)
    controller4.authenticate(password='PASS')
    controller4.signal(Signal.NEWNYM)
    controller5.authenticate(password='PASS')
    controller5.signal(Signal.NEWNYM)
    controller6.authenticate(password='PASS')
    controller6.signal(Signal.NEWNYM)
    controller7.authenticate(password='PASS')
    controller7.signal(Signal.NEWNYM)
    controller8.authenticate(password='PASS')
    controller8.signal(Signal.NEWNYM)

def show_my_ip():
    print("New IP is: " + requests.get('http://icanhazip.com/').text.strip())

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
    time.sleep(1)
    signal.signal(signal.SIGINT, signal_handler)
