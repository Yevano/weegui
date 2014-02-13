--@import see.util.Color
--@import see.concurrent.Thread

--@import weegui.element.Container
--@import weegui.element.MenuButton
--@import weegui.element.Element
--@import weegui.element.MenuBarButton

--@import weegui.util.Alignment

--@extends weegui.element.Container

function Menu:init(w, bg, fg)
    Container.init(self, nil, 1, 1, w, 0)
    self.bg = bg
    self.fg = fg
end

function Menu:addButton(string)
    string = cast(string, String)
    self.h = self.h + 1
    self.drawBuffer:resize(self.w, self.h)
    self:repaint()
    local button = MenuButton.new(self, self.children:length() + 1, self.w, string, self.bg, self.fg)
    button:setTextAlignment(Alignment.LEFT, Alignment.CENTER)
    return button
end

function Menu:addExpander(string)
    --return MenuExpanderButton.new()
end

function Menu:paint(ctx)
    ctx.char = " "
    ctx.bg = self.bg
    for i = 1, self.children:length() do
        local len = self.children[i].text:length()
        ctx:drawRect(len + 1, i, self.w - len, 1)
    end
    Container.paint(self, ctx)
end