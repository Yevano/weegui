--@import weegui.concurrent.GuiManager
--@import weegui.element.Button
--@import weegui.element.Element
--@import weegui.element.Label
--@import weegui.element.Window
--@import weegui.element.SelectionList

--@import see.concurrent.Thread
--@import see.util.Color

function WeeGuiDemo.main()
    local testWindow = Window.new(nil, 2, 2, 18, 14, "Test")
    local contentPanel = testWindow.contentPanel
    local label1 = Label.new(contentPanel, 2, 2, "Hello!", Color.BLACK, Color.WHITE)
    local label2 = Label.new(contentPanel, 2, 3, "4", Color.BLACK, Color.WHITE)
    local selectionList = SelectionList.new(contentPanel, 2, 5, 10, Color.GRAY, Color.WHITE, Array.new("Whoah", "1337hax", "yoyoyo", "#yolo", "#hashtag"))

    Window.new(nil, 20, 2, 13, 6, "Hello"):removeOnClose()
    Window.new(nil, 20, 2, 13, 6, "Hello"):removeOnClose()

    local running = true
    testWindow.closeButton:addListener(Element.CLICK, function(button, x, y)
        GuiManager.stop()
        running = false
    end)

    local pi = 4
    local i = 1
    while running do
        Thread.work()
        pi = pi - (4/(1 + i * 2))
        pi = pi + (4/(3 + i * 2))
        label2:setText(STR(pi))
        i = i + 2
    end
end