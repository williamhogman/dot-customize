hs.window.animationDuration = 0
-- Fix this!

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
end)

hs.hotkey.bind({"cmd", }, 39, function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h
      win:setFrame(f)
end)

hs.hotkey.bind({ "cmd"}, 10, function()
      hs.application.find()
end)

function open_hack(name)
   local w = hs.window.find(name)[1]
   if w ~= nil then
      w:focus()
   else
      hs.notify.new({title="No such window", informativeText=name}):send()
   end
end

switchy = hs.hotkey.modal.new('alt', 'space')
switchy:bind('', 'g', function() switchy:exit() end)
switchy:bind('', 's',function()
                hs.application.open("com.apple.Safari", nil, true)
                switchy:exit()
end)
switchy:bind('', 'c',function()
                hs.application.open("com.microsoft.VSCode", nil, true)
                switchy:exit()
end)

switchy:bind('', 'e',function()
                hs.application.launchOrFocus("Emacs")
                switchy:exit()
end)

switchy:bind('', 'i', function()
                hs.application.open("com.googlecode.iterm2", nil, true)
                switchy:exit()
end)

switchy:bind('', 'r', function()
                hs.application.open("com.reederapp.macOS", nil, true)
                switchy:exit()
end)

switchy:bind('', 'x', function()
                hs.application.open("com.google.chrome", nil, true)
                switchy:exit()
end)

switchy:bind('', 'd', function()
                -- open_hack("com.hnc.Discord")
                hs.application.launchOrFocus("Discord")
                switchy:exit()
end)
