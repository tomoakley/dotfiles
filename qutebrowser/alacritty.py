from qutebrowser.api import interceptor
from urllib.parse import urljoin
from PyQt6.QtCore import QUrl
import operator
import os
import subprocess

o = operator.methodcaller
s = 'setHost'
i = interceptor

def githubToAlacritty (url: QUrl) -> bool:
    p = subprocess.Popen(
        [
            '/Users/toakley/.qutebrowser/gh-nvim.sh',
            str(url)
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
    p.wait()
    out,err = p.communicate()
    print(out)
    return True

map = {
    "github.com/mediaingenuity/Account.NativeApp/pulls": githubToAlacritty,
}

def f(info: i.Request):
    if (info.resource_type != i.ResourceType.main_frame or
            info.request_url.scheme() in {"data", "blob"}):
        return
    url = info.request_url
    redir = map.get(url.host() + url.path())
    if redir is not None:
        redir(url)
i.register(f)
