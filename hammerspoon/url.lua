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

hs.urlevent.httpCallback = function(_, _, _, url, _)
  print(url)
  if string.match(url, "^https?://?github%.com/[%w%._%-]+/[%w%._%-]+/pulls?/?(%d*)$") ~= nil then
    local task = hs.task.new(
      "/Users/tomoakley/.qutebrowser/octo-nvim.sh",
      function ()
      end,
      {url}
    )
    task:start()
  --[[ elseif urlMatchesPattern(string.match(url, "://([^/]+)"), domainsToOpenInSafari) then
    local command = "open -a safari " .. url
    hs.execute(command)
  elseif urlMatchesPattern(string.match(url, "://([^/]+)"), domainsToOpenInChrome) then
    local command = "open -a '/Applications/Google Chrome.app' " .. url
    hs.execute(command)
  else
    local privacyRedirectUrl = privacyRedirects[string.match(url, "://([^/]+)")]..url:match("https?://[^/]+(.*)") or url
    print(privacyRedirectUrl)
    local task = hs.task.new("/opt/homebrew/bin/qutebrowser", nil, {"--target", "tab", url})
    task:start() ]]
  end
end
