# Qutebrowser URL Mutator

URL Mutator is a userscript written in Python that automatically mutates input URLs based on configurable rules. The rules are to be written in regex and the configuration file can be found at config.toml.

Additionally, portions of URLs that are percent encoded can be percent decoded, this helps get around certain types of trackers like out.reddit.com. You can specify which portions of a URL need to be decoded from percent encoding.

An example configuration file is provided with a few commonly mutated URLs and can be used to redirect Invidious, Reddit (to old reddit), out.reddit.com and Nitter out of the box. More URLs can be added if so desired.

An important point, this script mutates URLs BEFORE requests are sent.

## Why?

When using Chromium and Firefox, an extension called "Redirector" https://github.com/einaregilsson/Redirector was an important part of my workflow. After I began using Qutebrowser and significantly improving my workflow, i was still lacking that important element.

I found a script that hard coded certain proxies (https://github.com/qutebrowser/qutebrowser/discussions/6555) for certain sites but did not offer extensive user configurability, so I got to work.

Also, I wanted to learn how to implement Qutebrowser userscripts and see what they could do.

## Installation and usage

Clone this repository to your qutebrowser userscripts directory (usually ~/.config/qutebrowser/userscripts).

The script accepts the absolute (!) path to the configuration file, the command you want to run (e.g "open -t") and the URL to mutate as arguments. so to run it:

```
:spawn --userscript ~/.config/qutebrowser/userscripts/url_mutator/url_mutator.py /absolute/path/to/config "open -t" http://url.to.mutate/
```
Note the relative path to the script vs the absolute path to the configuration file. You can use absolute paths to the script also, this has to do with how Qutebrowser runs scripts.

Obviously change the path to the script and config. Also importantly, the command to run must be in quotes ( e.g "open", "open -t" etc.).

You can bind the script to keys, including hint links, as per your requirements and pass "open" or "open -t" depending on if you want to open in a new tab or not. You can also specify any command to run with the mutated URL that qutebrowser can run on URLs.

The script will pass the unmutated URL back if it isn't in the config (or is an ignored pattern), so you can replace your usual o, O, f and F keybinds if you always want it to mutate the specified URLs.

The script works with search queries as well! This is a side effect of the fact that "open" in qutebrowser handles search queries.

In the config, you can specify portions of the input URL to be percent decoded. If a portion is percent encoded and you don't want that, you can re-encode it!

The script can be used to create aliases for URLS. Since the script can parse any regex, you can create a config entry for an alias, so that when you pass the alias through the script it will return the URL you want to go to.

The script can be used as a library from within another python script. When called, the URL to mutate must be provided, and optionally, a path to a config file if config.toml is not in the local directory or if it has a different name.

for example:
```
import url_mutator

mutated_url = url_mutator(unmutated_url, "path/to/conf")
```

I did this so that it can be used in other qutebrowser userscripts, for example if you wanted to pass a mutated URL to another userscript, you could import it into that script.

Technically, this means this script can be used to configurably mutate any exact matches to any strings you want in any python program, which is cool. I wouldn't use it like that though, there are better tools for more general string mutation.

### Useful keybinds

How you use the script depends your needs, however the most common use cases are probably going to be similar to o, O, f and F.

I replace default behavior because I want all URLs to be mutated, and make new binds (CTRL+o, CTRL+O, etc) for the normal behavior in the event I need it. You can set the keybinds to whichever keys you like by changing the key after ":bind".

```
:bind o set-cmd-text -s :spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open"
```
```
:bind O set-cmd-text -s :spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open -t"
```

The same thing with e, E (opening the URL in the clipboard directly):

```
:bind e spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open" {clipboard}
```
```
:bind E spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open -t" {clipboard}
```

Finally, use the script for links followed when hinting (f, F):

```
:bind f hint links spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open" {hint-url}
```
```
:bind F hint links spawn --userscript <path_to_userscripts_folder>/url_mutator/url_mutator.py <absolute_path_to_userscripts_folder>/url_mutator/config.toml "open -t" {hint-url}
```

## Dependencies

This script depends on the following python libraries: 
- toml for reading the configuration file, 
- re for regex parsing, 
- os for getting environment variables from Qutebrowser, and 
- sys for getting args.
- urllib for percent decoding

## Wrapping up

This script is fully functional and is feature complete, however certain behavior might be improved. If you find it to do anything strange or quirky feel free to open an issue.

Improvements and pull requests for improved functionality are welcome, however additional features beyond user configurable URL parsing and mutating (for Qutebrowser specifically) will not be merged as that is the totality of the scope of this project.

This script is maintained! It is not something that needs to change often, so just because it hasn't been updated for a long time does not mean it is broken or unmaintained.

Qutebrowser is a very niche browser and as such userscripts that extend the browser in powerful ways are hard to find, if you like this script (or anything else I have done) and feel like buying me a beer feel free to send me a few bucks:

XMR: 4AeufJrhpQn7LGW5dZ9tH4FFAtfmRwEDvhYrH5GQDbNxQ9VyWKmdycb5naWcvRTqbm3fkyqrDi23x453stDKzu5YVgPfcbj

BTC legacy: 141HaN7bq781BaB2PRP8mkUndebZXjxiFU

BTC segwit compatible: bc1qx2fa50av3j9hrjnszsnpflmtxqnz08936mq4xx

BCH: qzr9gk7tv274x9u9sft243m729zrjnq0cvpzlelapt

LTC: ltc1qa8re5eh2dklzfhg2x03tswsr5wae68qfxjzacd

ETH: 0x18304c5ed37dacefc920b291f39b06545b5fc258

I will give some portion (at my discretion) of any donations I get to The-Compiler for maintaining Qutebrowser, as well as to other FOSS tools I use.

You can always do that as well! Many of us put a lot of effort into things just because we want to see them exist and make people's lives better, and it is always nice when people appreciate and support us for what we do.
