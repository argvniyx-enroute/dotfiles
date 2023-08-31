hs.loadSpoon("SpoonInstall")

-- App launching
spoon.SpoonInstall:andUse("AppLauncher", {
  hotkeys = {
    e = "Emacs",
    i = "IntelliJ IDEA",
    l = "Slack",
    o = "Obsidian",
    n = "Logseq",
    p = "Spotify",
    s = "Google Chrome",
    t = "Kitty",
    z = "Zoom.us"
  },
  config = {
    modifiers = { "cmd", "alt", "ctrl"},
  }
})

-- Window focus
hs.hotkey.bind({ "alt" }, "h", function()
    hs.window.focusedWindow():focusWindowWest()
end)

hs.hotkey.bind({ "alt" }, "j", function()
    hs.window.focusedWindow():focusWindowSouth()
end)

hs.hotkey.bind({ "alt" }, "k", function()
    hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind({ "alt" }, "l", function()
    hs.window.focusedWindow():focusWindowEast()
end)

-- Initial app opening
hs.application.launchOrFocus("Emacs")
hs.application.launchOrFocus("Slack")
hs.application.launchOrFocus("Google Chrome")
