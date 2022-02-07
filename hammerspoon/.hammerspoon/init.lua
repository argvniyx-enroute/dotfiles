hs.loadSpoon("SpoonInstall")

-- App launching
spoon.SpoonInstall:andUse("AppLauncher", {
  hotkeys = {
    s = "Google Chrome",
    e = "Emacs",
    l = "Slack",
    t = "Kitty",
    p = "Spotify",
    z = "Zoom.us"
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
