local TEAMS_DOMAIN = "teams.public.onecdn.static.microsoft"
local function convertSlackUrl(url)
  return url:gsub("^https://app.slack.com/client/(%w+)/(%w+)?open=start_huddle$", "slack://join-huddle\\?team=%1\\&id=%2")
end

hs.urlevent.httpCallback = function(_, _, _, url, _)
  local isSlackHuddleUrl = url:match("^https://app.slack.com/client/.+?/?open=start_huddle$")
  if isSlackHuddleUrl then
    local converted = convertSlackUrl(url)
    local command = "open -a chrome" .. converted
    hs.execute(command)
  end
end

local domainsToOpenInSafari = { "notion.so", "figma.com", "sentry.io", "localhost:9001", 'miro.com' }
local domainsToOpenInChrome = { "docs.google.com" }
local privacyRedirects = {
  ["reddit.com"] = "farside.link/libreddit",
  ["old.reddit.com"] = "farside.link/libreddit",
  ["twitter.com"] = "nitter.net",
  ["x.com"] = "nitter.net",
  ["medium.com"] = "farside.link/scribe",
  ["youtube.com"] = "farside.link/invidious",
  ["youtu.be"] = "farside.link/invidious",
  ["stackoverflow.com"] = "farside.link/anonymousoverflow",
  ["google.com"] = "farside.link/whoogle",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
  -- [""] = "",
}

local function urlMatchesPattern(domain, urlTable)
  for _, item in ipairs(urlTable) do
    if  domain == item then
      return true
    end
  end
  return false
end

--- Returns true if `url`'s host is DOMAIN or a subdomain of it.
local function url_is_under_domain(url)
  -- 1. Strip the scheme (https://, http://, file://, ...).
  --    %a[%w+.-]* matches "https", "http", "git+ssh", etc.
  local rest = url:match("^%a[%w+.-]*://(.*)$") or url

  -- 2. The host is everything up to the first "/", "?" or "#".
  local host = rest:match("^([^/%?#]+)") or ""

  -- 3. Drop any "user:pass@" userinfo, then any ":port".
  host = host:match("@(.+)$") or host
  host = host:match("^([^:]+)") or host

  -- 4. Hostnames are case-insensitive; lowercase both sides.
  host = host:lower()
  local domain = TEAMS_DOMAIN:lower()

  -- 5. Exact match, or the host ends with ".domain" (subdomain).
  return host == domain or host:sub(-#domain - 1) == "." .. domain
end

--- Decode application/x-www-form-urlencoded text.
--- Turns "%2F" into "/", and "+" into a space.
local function url_decode(s)
  -- NOTE: "+" is a magic pattern char in Lua, so it must be escaped as "%+".
  -- Do this BEFORE %XX decoding, so a literal "%2B" still becomes "+".
  s = s:gsub("%+", " ")
  return (s:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end))
end

--- Return the value of the named query parameter, or nil if absent.
local function get_query_param(url, name)
  -- 1. Take everything after the first "?" ("%?" escapes the magic "?").
  local query = url:match("%?(.*)")
  if not query then return nil end

  -- 2. Drop the fragment, if any ("...#section").
  query = query:match("^([^#]*)") or query

  -- 3. Walk the "key=value&key=value" pairs.
  for pair in query:gmatch("[^&]+") do
    -- Split on the FIRST "=" only, so values containing "=" survive.
    local key, value = pair:match("^([^=]*)=(.*)$")
    if not key then
      key, value = pair, ""        -- bare flag: "?debug" => value ""
    end

    if url_decode(key) == name then
      return url_decode(value)     -- first match wins; returns just this value
    end
  end

  return nil                       -- not present
end

local isWorkMac = hs.application.infoForBundlePath("/Applications/Microsoft Teams.app")

local function urlencode(str)
  if not str then return str end
  -- convert newlines first
  str = string.gsub(str, "\n", "\r\n")
  -- encode anything that isn't unreserved
  str = string.gsub(str, "[^%w%.%-_~]",
    function(c)
      return string.format("%%%02X", string.byte(c))
    end)
  return str
end


local function urldecode(str)
    -- Replace + with space (common in query strings)
    str = string.gsub(str, "+", " ")

    -- Replace %XX with the corresponding character
    str = string.gsub(str, "%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end)

    return str
end

local function getURLParam(url, paramName)
    local parts = hs.http.urlParts(url)

    if parts and parts.query then
        for pair in string.gmatch(parts.query, "[^&]+") do
            local key, value = string.match(pair, "([^=]+)=([^=]+)")
            if key == paramName then
                return value
            end
        end
    end

    return nil  -- Parameter not found
end

local function openInOctoNvim(url)
  if string.match(url, "^https?://?github%.com/[%w%._%-]+/[%w%._%-]+/pulls?/?(%d*)$") ~= nil then
    local task = hs.task.new(
      "/Users/tomoakley/.qutebrowser/octo-nvim.sh",
      function ()
      end,
      {url}
    )
    task:start()
    return true
  end
  return false
end


-- https://teams.public.onecdn.static.microsoft/evergreen-assets/safelinks/2/atp-safelinks.html?url=https%3A%2F%2Fgithub.com%2Filg-totallymoney%2FAccount.NativeApp%2Fpull%2F9923&locale=en-gb&dest=https%3A%2F%2Fteams.microsoft.com%2Fapi%2Fmt%2Femea%2Fbeta%2Fatpsafelinks%2Fgeturlreputationsitev2%2F&pc=Y6J%252BuZ0x2hV7fpVe6ddWxEB9s9%252FMJlZMZFKWgHVjr9DfSCaJOZOAaXMNVPDnWlZubLJK5id8fRnn%252FCBY2qItpX2G4HJn3qmfQCouPbeqEEFOaPVdqHQIiXIf71gP19AvyRNRElsZM4jI%252FEVpp8vs6AjO0BP%252F5ZFQuIyNR%252Bs1ENUXk124jmWwHdf%252FWtWdnRNcuNMCGilhJvTBmjcAZflm3rjHh1lSkB%252FVNQt88UCJn6w11Xo7q22ntWyPAXwoIJnRfSzz%252B0uYMTdtx4V4lXVJkDJz1%252Ft8IYxG3uCGp%252BpyKuJErLHodUz%252BHT0rPhnTZ89ZqAA8MO8QHcTZXSreTHp0rwqbuA04QtVzD6lfq8V3LZ9UnNp%252Fj%252F3523RvAiScstQy08eZkosqHGDf9xvPd5RHgiE6k7I5bSToicKUeHt23pfA4tBB0CHGa7WE2BsPRnu5dFzOSAy2cKz%252BWLwEOnndP%252FGXlrdQbo37srxdG5zaX6Ovq0JUl9%252FEDg69tAytB6hUv5zmxnuL794v5KFKGHv9H0Hg5XwJkH%252BxrHlI3totfnSB2nvgu%252FKs%252F1bLAvUqFyYq10v77b3GhcbAj2YDheMkdv%252FP5afZ4HOukeNuYbNa%252B0buc9ZY3aAYEdUy5If2ZjD%252FLhYlw1oH3EGRzUoH9oF7b%252FRbolME4vHRuJZBvtUBlKtgDMI22bk6KRHkHXpMZRkRVpDjcogTic7SMCudIPxtBRo%252B%252BZhTxOquecbZ1sD7gSENYGOO0iAlSXhk592vQmwTwcuMgDdmQDzbwb8Ne8GTavZtn0MMVGvBhUyaRsybvQpSSgfM98KapEgZmxyQWj3ZepA2aLKhJqRGNJcI8%252BKbkxXEtiuj0Wgk20I8LcgO7%252B%252BR6EKictjC7Ld1%252BvTArNaw3OAatkTNjpBMKogw8%252B8HhBKxOuB0UKxFlfgQyLZ4LjUrYcCMEKSz2xBOCH78OGRclkwtXc%252B%252BB5bOOS8O%252F8de0oNVwopIGzxA9Reyrwy%252FhgKuYcC4fMuK4x6YIAqEkNXIY1oZlT1xPSCQ0oDGb5C9ApANpPhevhEoomBmtbcUv%252BmKtqbAIM7YrKUdfV%252B%252F66YyVeYcbe9kaaXrN8jsAiz3j1H%252BSCmUzjdRGzkt39%252Fvlbe3n91vNQqJDiyj13A77BAWkYg8TvTQyjaFRRfYCZay9pPxbOV15WiH5RDVBuqXGSat%252F0lWMVNlCYi6SUnxPm%252FQZNAGtcLtLyAWr6SlMCsiNklNNmf6iqlz%252BAo%252Fsm59ZkQKifAQ7U5UbAtM92o2nWLFbFrvxytr8rHc%252Bt%252B7GzeFfIszXth8oeTndc3RALxblO64Kw8ste2DzQl42CXYF%252BoL9e2dmAcf%252F7BsynyJC8lIZueFYv%252BTr5Mz9f3uzs4t222jVCAy47Ba2tZxLpYXFUi%252FgWEC%252Fo7YXxnOiFT1XjhNfkszXBAWDLeCV3%252BrusnArAg%253D%3B%20expires%3DFri%2C%2016%20Oct%202026%2013%3A46%3A25%20GMT%3B%20path%3D%2F%3B%20SameSite%3DNone%3B%20secure%3B%20httponly&wau=https%3A%2F%2FGBR01.safelinks.protection.outlook.com%2FGetUrlReputation&si=undefined%3B8340356034117665006%3B19%3A6a131f1140d8469d907369c55abc1899%40thread.tacv2&sd=%7BconvId%3A%2019%3A6a131f1140d8469d907369c55abc1899%40thread.tacv2%2C%20messageId%3A%208340356034117665006%7D&ce=prod&cv=50%2F26091712213&ssid=9BB34579-8917-4F3E-AD4D-D9439F4D28B8&ring=general&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI1MC8yNjA5MTcxMjIxMyJ9&bg=%23f0f0f0&fg=%23242424&fg2=%239092c1
hs.urlevent.httpCallback = function(_, _, _, url, _)
  if openInOctoNvim(url) then
    return
  --[[ elseif urlMatchesPattern(string.match(url, "://([^/]+)"), domainsToOpenInSafari) then
    local command = "open -a safari " .. url
    hs.execute(command)
  elseif urlMatchesPattern(string.match(url, "://([^/]+)"), domainsToOpenInChrome) then
    local command = "open -a '/Applications/Google Chrome.app' " .. url
    hs.execute(command) ]]
  elseif isWorkMac then
    --print('DEBUG: Opened URL '..urlencode(url))
    local isTeamsSafeLink = string.find(url, "^" .. 'https://teams.public.onecdn.static.microsoft') ~= nil
    if isTeamsSafeLink then
      local actualUrl = getURLParam(url, 'url')
      if openInOctoNvim(urldecode(actualUrl)) then
        return
      end
    end
    local command =  "open -a '/Applications/Google Chrome.app' '" ..url:gsub("'", "'\\''") .. "'"
    hs.execute(command)
  else
    --[[ local privacyRedirectUrl = privacyRedirects[string.match(url, "://([^/]+)")]..url:match("https?://[^/]+(.*)") or url
    print(privacyRedirectUrl) ]]
    local task = hs.task.new("/opt/homebrew/bin/qutebrowser", nil, {"--target", "tab", url})
    task:start()
  end
end
