#!/usr/local/bin/qutebrowser/.venv/bin/python3

import toml
import re
import os
import sys
from urllib.parse import unquote as unquote
from pathlib import Path

HOME_DIR = str(Path().home())

# just reads the configuration file
def read_conf(conf_file):
    conf_file = open(conf_file)
    conf = toml.loads(conf_file.read())
    conf_file.close()
    return conf

# takes the URL list, the numbers from it and the indexes from the conf you want to be percent decoded, returns the URL list with requested items percent decoded
def percent_decode(out_url_list, indexes_list, conf_index_list):
    for number in indexes_list:
        if number in conf_index_list:
            out_url_list[indexes_list.index(number)] = unquote(out_url_list[indexes_list.index(number)])
    return out_url_list


# takes URL and path to conf file (optional, default local config.toml) and returns mutated URL if a conf entry exists for URL scheme
def mutator(url, conf = "config.toml"):
    conf = read_conf(conf)
    final_url = url
    for scheme in conf["mutator"]:
        match = re.fullmatch(str(conf['mutator'][scheme]["in_url"]), url)
        if match != None:
            if re.fullmatch(str(conf["mutator"][scheme]["ignore_pattern"]), url) == None:
                out_url_list = str(conf["mutator"][scheme]["out_url"]).split("|")
                indexes_list = str(conf["mutator"][scheme]["out_url"]).split("|")
                for item in indexes_list:
                    try:
                        item = int(item)
                    except:
                        indexes_list[indexes_list.index(item)] = '0'
                for n in out_url_list:
                    if re.fullmatch("\d+", n) != None:
                        out_url_list[out_url_list.index(n)] = match.group(int(n))
                out_url_list = percent_decode(out_url_list, indexes_list, str(conf["mutator"][scheme]["percent_decode"]).split(","))
                final_url = "".join(out_url_list)
                break
    return final_url

def qutebrowser_run():
    conf = HOME_DIR + "/.qutebrowser/userscripts/url_mutator/config.toml"
    qute_command = sys.argv[1]
    # URL is everything after other args, allows for search queries without quotes
    for thing in sys.argv[2:]:
        if " " in thing:
            sys.argv[sys.argv.index(thing)] = '"' + thing + '"'
    url = ' '.join(sys.argv[2:])
    final_url = mutator(url, conf)
    with open(os.environ["QUTE_FIFO"], "a") as output:
        output.write(qute_command + " " + final_url)

# if called from qutebrowser use argsv, if called as a library pass args directly to mutator function
if __name__ == "__main__":
    qutebrowser_run()
else:
    mutator(url, conf)
