from qutebrowser.api import interceptor
from urllib.parse import urljoin
from PyQt6.QtCore import QUrl
import operator
import subprocess
import re

o = operator.methodcaller
s = 'setHost'
i = interceptor

def githubToAlacritty (url: QUrl) -> bool:
    p = subprocess.Popen(
        [
            '/Users/toakley/.qutebrowser/octo-nvim.sh',
            str(url)
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
    p.wait()
    out,err = p.communicate()
    print(out)
    return True

def farside(url: QUrl, i) -> bool:
    url.setHost('farside.link')
    p = url.path().strip('/')
    url.setPath(urljoin(i, p))
    return True

def nitter(url: QUrl) -> bool:
    return farside(url, '/nitter/')
def rimgo(url: QUrl) -> bool:
    return farside(url, '/rimgo/')
def scribe(url: QUrl) -> bool:
    return farside(url, '/scribe/')
def invid(url: QUrl) -> bool:
    return farside(url, '/invidious/')
def reddit(url: QUrl) -> bool:
    return farside(url, '/libreddit/')
def bibliogram(url: QUrl) -> bool:
    return farside(url, '/bibliogram/')
def simplytranslate(url: QUrl) -> bool:
    return farside(url, '/simplytranslate/')
def proxitok(url: QUrl) -> bool:
    return farside(url, '/proxitok/')
def querte (url: QUrl) -> bool:
    return farside(url, '/querte/')
def breezewiki (url: QUrl) -> bool:
    return farside(url, '/breezewiki/')
def dumb (url: QUrl) -> bool:
    return farside(url, '/dumb/')
def anonymousoverflow (url: QUrl) -> bool:
    return farside(url, '/anonymousoverflow/')
def whoogle (url: QUrl) -> bool:
    return farside(url, '/whoogle/')

redirMap = {
    "reddit.com": reddit,
    "www.reddit.com": reddit,
    "old.reddit.com": reddit,

    "youtu.be": invid,
    "youtube.com": invid,
    "www.youtube.com": invid,

    "twitter.com": nitter,
    "mobile.twitter.com": nitter,

    "imgur.com" : rimgo,
    "medium.com" : scribe,
    "www.instagram.com": bibliogram,
    "translate.google.com" : simplytranslate,
    "tiktok.com" : proxitok,
    "vm.tiktok.com" : proxitok,
    "www.tiktok.com" : proxitok,
    "www.quora.com": querte,
    "fandom.com": breezewiki,
    "www.fandom.com": breezewiki,
    "genius.com" : dumb,
    "stackoverflow.com" : anonymousoverflow,
    "google.com": whoogle,
    "www.google.com": whoogle,

    "tumblr.com" : o(s, 'splashblr.fly.dev'),
}

appMap = {
    r"[https]?github\.com\/[a-zA-Z0-9].+\/pull[s]?[\/[\d]*]?$": githubToAlacritty,
}

def appRegexMap(url):
    for pattern, method in appMap.items():
        if re.match(pattern, url):
            return method
    return

def f(info: i.Request):
    if (info.resource_type != i.ResourceType.main_frame or
            info.request_url.scheme() in {"data", "blob"}):
        return
    url = info.request_url
    redir = redirMap.get(url.host())
    if redir is not None and redir(url) is not False:
        info.redirect(url)
    app = appRegexMap(url.host() + url.path())
    if app is not None:
         app(url)

i.register(f)
