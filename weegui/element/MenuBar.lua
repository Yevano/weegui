--@import see.util.Color

--@import weegui.element.Container
--@import weegui.element.MenuBarButton

--@extends weegui.element.Container

function MenuBar:init(parent, x, y, w, strings, bg, fg)
    Container.init(self, parent, x, y, w, 1)
    self.bg = bg
    self.fg = fg

    local cx = 1
    for i = 1, strings:length() do
        local button = MenuBarButton.new(self, cx, strings[i], bg, fg)
        cx = cx + button.w
    end

    self.buttonsLength = cx
end

function MenuBar:paint(ctx)
    ctx.char = " "
    ctx.bg = Color.GRAY
    ctx:drawRect(self.buttonsLength, 1, self.w - self.buttonsLength + 1, 1)
    Container.paint(self, ctx)
end