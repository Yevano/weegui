--@import see.util.Color

--@import weegui.element.Container
--@import weegui.element.MenuBarButton
--@import weegui.element.Menu

--@extends weegui.element.Container

function MenuBar:init(parent, x, y, w, bg, fg)
    Container.init(self, parent, x, y, w, 1)
    self.bg = bg
    self.fg = fg
    self.right = 1
end

function MenuBar:addMenu(string, w)
    string = cast(string, String)
    local button = MenuBarButton.new(self, self.right, string, self.bg, self.fg)
    local menu = Menu.new(w, self.bg, self.fg)
    button:setMenu(menu)
    self.right = string:length() + 2
    return menu
end

function MenuBar:paint(ctx)
    ctx.char = " "
    ctx.bg = self.bg
    ctx:drawRect(self.right, 1, self.w - self.right + 1, 1)
    Container.paint(self, ctx)
end