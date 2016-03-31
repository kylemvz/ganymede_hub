import json

from tornado.httpclient import HTTPClient, HTTPError
from tornado.netutil import Resolver

from .UnixResolver import UnixResolver

resolver = UnixResolver(resolver=Resolver(), socket_path='/var/run/restuser.sock')
client = HTTPClient(resolver=resolver)

def add_user(name):
    try:
       resp = client.fetch('http://unix+restuser/' + name, method='POST', body='{}')
    except HTTPError as e:
        print(e.response.code, e.response.body.decode('utf8', 'replace'))
        return
    user = json.loads(resp.body.decode('utf8', 'replace'))
    return user