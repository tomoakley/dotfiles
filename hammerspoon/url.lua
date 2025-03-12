local function convertSlackUrl(url)
  return url:gsub("^https://app.slack.com/client/(%w+)/(%w+)?open=start_huddle$", "slack://join-huddle\\?team=%1\\&id=%2")
end

hs.urlevent.httpCallback = function(_, _, _, url, _)
  local isSlackHuddleUrl = url:match("^https://app.slack.com/client/.+?/?open=start_huddle$")
  if isSlackHuddleUrl then
    local converted = convertSlackUrl(url)
    local command = "open -a safari " .. converted
    hs.execute(command)
  end
end

local domainsToOpenInSafari = { "notion.so", "figma.com", "sentry.io" }
local domainsToOpenInChrome = { "google.com" }

local function urlMatchesPattern(domain, urlTable)
  for _, item in ipairs(urlTable) do
    if  domain == item then
      return true
    end
  end
  return false
end

hs.urlevent.httpCallback = function(_, _, _, url, _)
  if string.match(url, "^https?://?github%.com/[%w%._%-]+/[%w%._%-]+/pulls?/?(%d*)$") ~= nil then
    local task = hs.task.new(
      "/Users/tomoakley/.qutebrowser/octo-nvim.sh",
      function ()
      end,
      {url}
    )
    task:start()
  elseif urlMatchesPattern(string.match(url, '[%w%.]*%.(%w+%.%w+)'), domainsToOpenInSafari) then
    local task = hs.task.new("/usr/bin/open", nil, {"-a /Applications/Safari.app", url})
    task:start()
  elseif urlMatchesPattern(string.match(url, '[%w%.]*%.(%w+%.%w+)'), domainsToOpenInChrome) then
    print(url)
    local task = hs.task.new("/usr/bin/open", nil, {"-a '/Applications/Google Chrome.app'", url})
    task:start()
  else
    local task = hs.task.new("/opt/homebrew/bin/qutebrowser", nil, {"--target", "tab", url})
    task:start()
  end
end
