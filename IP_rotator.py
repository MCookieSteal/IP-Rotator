import time
import socket
import socks
import requests
from stem import Signal
from stem.control import Controller
from urllib.request import ProxyHandler, build_opener, install_opener

controller = Controller.from_port(port=9051)

def _set_url_proxy():
    proxy_support = ProxyHandler({'http': '127.0.0.1:8118'})
    opener = build_opener(proxy_support)
    install_opener(opener)
_set_url_proxy()
def connectTor():
    socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5 , "127.0.0.1", 9050, True)
    socket.socket = socks.socksocket


def renew_tor():
    controller.authenticate(password='YOUR_PASSWORD')
    controller.signal(Signal.NEWNYM)


def show_my_ip():
    print("New IP is: " + requests.get('http://icanhazip.com/').text.strip())


for i in range(1000000000000000):
    renew_tor()
    connectTor()
    show_my_ip()
    time.sleep(10)
