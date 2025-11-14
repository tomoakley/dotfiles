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
    local isTeamsSafeLink = string.find(url, "^" .. 'https://statics.teams.cdn.office.net') ~= nil
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
