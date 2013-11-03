--@import see.util.Color
--@import see.concurrent.Thread

--@import weegui.element.Container
--@import weegui.element.MenuButton
--@import weegui.element.Element

--@extends weegui.element.Container

function Menu:init(w, strings, bg, fg)
    Container.init(self, false, 1, 1, w, strings:length())
    self.bg = bg
    self.fg = fg

    for i = 1, strings:length() do
        MenuButton.new(self, i, strings[i], bg, fg)
    end

    self:addListener(Element.UNFOCUS, function()
        Thread.new(function()
            Thread.sleep(0.5)
            --self:remove()
        end):start()
    end)
end

function Menu:paint(ctx)
    ctx.char = " "
    ctx.bg = Color.GRAY
    for i = 1, self.children:length() do
        local len = self.children[i].text:length()
        ctx:drawRect(len + 1, i, self.w - len, 1)
    end
    Container.paint(self, ctx)
end